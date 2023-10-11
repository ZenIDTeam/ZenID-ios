import argparse
import os
import hashlib
import shutil



def check_extract_files(sdk_root, version):
    print("1️⃣. Checking and extracting required archives ...")
    models = os.path.join(sdk_root, 'sdk_ZenidModels_{0}.zip'.format(version))
    sdk = os.path.join(sdk_root, 'sdk_iOS_{0}.zip'.format(version))
    signature = os.path.join(sdk_root, 'sdk_{0}.signature.zip'.format(version))

    for file_name in [models, sdk, signature]:
        if not os.path.isfile(file_name):
            print("🛑 File {0} not found. Aborting.".format(file_name))
            exit(1)

    for file_name in [models, sdk, signature]:
        print("Extracting {0}".format(file_name))
        #os.system('unzip -o {0} -d {1}'.format(file_name, sdk_root))
        shutil.unpack_archive(file_name, sdk_root)


def checksum_verification(sdk_root, version):
    print()
    print("2️⃣. Verification of checksums ...")
    checksum_filename = os.path.join(sdk_root, 'signature', 'checksums.txt')
    checksum_file = open(checksum_filename, 'r')
    checksum_file_content = checksum_file.readlines()
    verified_filenames = []

    for check_line in checksum_file_content:
        # print(check_line)
        file_checksum, file_name = check_line.rstrip().replace('\n', '').replace('  ', ' ').split(' ')
        if 'android' in file_name:
            continue
        checked_filename = os.path.join(sdk_root, file_name)
        verified_filenames.append(checked_filename)
        if not os.path.isfile(checked_filename):
            print("{0} file not found.".format(checked_filename))
            exit(1)
        else:
            sha256_hash = hashlib.sha256()
            with open(checked_filename,"rb") as f:
                # Read and update hash string value in blocks of 4K
                for byte_block in iter(lambda: f.read(4096),b""):
                    sha256_hash.update(byte_block)

            hexdigest = sha256_hash.hexdigest()
            if hexdigest == file_checksum:
                print("{0} checksum is valid ✅".format(file_name))
            else:
                print("🛑 {0} has an invalid checksum. Aborting.".format(file_name))
                exit(1)
    return verified_filenames


def extract_models(sdk_root, models_archive):
    print()
    print("3️⃣. Extracting models ...")
    
    old_models_dir = os.path.join(sdk_root, 'models')
    models_dir = os.path.join(sdk_root, 'Models')
    documents_dir = os.path.join(models_dir, 'documents')
    face_dir = os.path.join(models_dir, 'face')
    
    if os.path.isdir(models_dir):
        shutil.rmtree(models_dir)

    os.system('unzip -o {0} -d {1}'.format(models_archive, sdk_root))

    #rename dirs to uppercase
    print("Rename and move directories ...")
    shutil.move(old_models_dir, models_dir)

    if os.path.isdir(documents_dir):
        shutil.rmtree(documents_dir)
    if os.path.isdir(face_dir):
        shutil.rmtree(face_dir)

    model_directories = os.listdir(models_dir)

    os.mkdir(documents_dir)
    os.mkdir(face_dir)

    
    for f in model_directories:
        full_path = os.path.join(models_dir, f)
        if os.path.isdir(full_path):
            new_dir_name = f.upper()
            #print("{0} => {1}".format(f, new_dir_name))

            if new_dir_name == 'LIVENESS':
                shutil.rmtree(full_path)
            elif new_dir_name == 'SELFIE':
                for sf in os.listdir(full_path):
                    shutil.move(os.path.join(full_path, sf), os.path.join(face_dir, sf))
                shutil.rmtree(full_path)
            else:
                target_path = os.path.join(documents_dir, new_dir_name)
                shutil.move(full_path, target_path)


def replace_models(sdk_root, project_root):
    project_models_dir = os.path.join(project_root, 'Models')
    update_models_dir = os.path.join(sdk_root, 'Models')
    
    print("Moving new models into project at {0}".format(project_models_dir))
    #shutil.rmtree(project_models_dir)
    #shutil.move(update_models_dir, project_models_dir)


def replace_sdk(sdk_root, project_root, libzen_archive):
    print()
    print("4️⃣. Extracting sdk project ...")

    xcproj_dir = os.path.join(sdk_root, 'libzen')
    xcframework = os.path.join(xcproj_dir, 'LibZenid_iOS.xcframework')

    if os.path.isdir(xcproj_dir):
        shutil.rmtree(xcproj_dir)

    os.system('unzip -o {0} -d {1}'.format(libzen_archive, xcproj_dir))
    os.system('chmod -R 0755 {0}'.format(xcframework))

    project_xcframework = os.path.join(project_root, 'Sources', 'LibZenid_iOS.xcframework')
    print("Replacing SDK on path {0}".format(project_xcframework))

    shutil.rmtree(project_xcframework)
    shutil.move(xcframework, project_xcframework)


def process_update(sdk_root, project_root, version):
    print("Processing SDK update")
    print(" version: {0}".format(version))
    print(" update source dir: {0}".format(sdk_root))
    print(" target project dir: {0}".format(project_root))
    print()

    check_extract_files(sdk_root, version)
    
    verified_files = checksum_verification(sdk_root, version)
    
    models_archive = [ j for j in verified_files if j.find("sdk_ZenidModels_")!=-1 ][0]
    extract_models(sdk_root, models_archive)
    replace_models(sdk_root, project_root)

    # LibZenid xcproject
    libzen_archive = [ j for j in verified_files if j.find("sdk_iOS_")!=-1 ][0]
    replace_sdk(sdk_root, project_root, libzen_archive)
    print()


def main():
    parser = argparse.ArgumentParser(description='Extract and verify signature of ZenID SDK update.')
    parser.add_argument('version', metavar='sdk-version', type=str,
                    help='SDK version')
    parser.add_argument('path', metavar='path-to-downloaded-sdk', type=str,
                    help='Directory with Models.zip, signature.zip, ZenidMobileSdk.zip downloaded')
    parser.add_argument('project_path', metavar='project_path', type=str,
                    help='Directory with ZenID project')

    args = parser.parse_args()

    sdk_version = args.version
    sdk_root = args.path
    project_path = args.project_path

    process_update(sdk_root, project_path, sdk_version)


if __name__ == '__main__':
    main()
    # process_update('/Users/lgergel3579ab/Downloads/zenid-2.12.2', '/Users/lgergel3579ab/Development/skoumal/ZenID-ios')