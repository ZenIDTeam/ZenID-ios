import argparse
import os
import hashlib
import shutil



def extract_files(sdk_root, version):
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

# Install new models.
# 1. extract new models
# 2. move new models to Models directory
# 3. delete old directories for documents, mrz and liveness.
# 4. move files to their respective directories.
def install_models(sdk_root, models_archive):
    print()
    print("3️⃣. Extracting models ...")
    
    old_models_dir = os.path.join(sdk_root, 'models')
    models_dir = os.path.join(sdk_root, 'Models')
    documents_dir = os.path.join(models_dir, 'documents')
    face_dir = os.path.join(models_dir, 'face')
    mrz_dir = os.path.join(models_dir, 'mrz')
    
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
    if os.path.isdir(mrz_dir):
        shutil.rmtree(mrz_dir)

    model_directories = os.listdir(models_dir)

    os.mkdir(documents_dir)
    os.mkdir(face_dir)
    os.mkdir(mrz_dir)
    
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
            elif new_dir_name == 'DOCUMENT':
                for sf in os.listdir(full_path):
                    shutil.move(os.path.join(full_path, sf), os.path.join(mrz_dir, sf))
                shutil.rmtree(full_path)
            else:
                target_path = os.path.join(documents_dir, new_dir_name)
                shutil.move(full_path, target_path)


def replace_models(sdk_root, project_root):
    project_models_dir = os.path.join(project_root, 'Models')
    update_models_dir = os.path.join(sdk_root, 'Models')
    
    print("Moving new models into project at {0}".format(project_models_dir))
    shutil.rmtree(project_models_dir)
    shutil.move(update_models_dir, project_models_dir)


def replace_sdk(sdk_root, project_root, libzen_archive):
    print()
    print("4️⃣. Extracting sdk project ...")

    xcproj_dir = os.path.join(sdk_root, 'Sources')
    xcframework = os.path.join(xcproj_dir, 'LibZenid_iOS.xcframework')
    opensource = os.path.join(xcproj_dir, 'open-source-licenses.txt')

    if os.path.isdir(xcproj_dir):
        shutil.rmtree(xcproj_dir)

    os.system('unzip -o {0} -d {1}'.format(libzen_archive, xcproj_dir))
    os.system('chmod -R 0755 {0}'.format(xcframework))
    os.system('chmod -R 0755 {0}'.format(opensource))

    project_xcframework = os.path.join(project_root, 'Sources', 'LibZenid_iOS.xcframework')
    print("Replacing SDK on path {0}".format(project_xcframework))
    shutil.rmtree(project_xcframework)
    shutil.move(xcframework, project_xcframework)

    project_opensource = os.path.join(project_root, 'Sources', 'open-source-licenses.txt')
    print("Replacing open source declaration on path {0}".format(project_opensource))
    os.remove(project_opensource)
    shutil.move(opensource, project_opensource)

# Run update process.
def process_update(sdk_root, project_root, version):
    print("Processing SDK update")
    print(" version: {0}".format(version))
    print(" update source dir: {0}".format(sdk_root))
    print(" target project dir: {0}".format(project_root))
    print()
    # step 1: extract files
    extract_files(sdk_root, version)
    
    # step 2: calculate checksums.
    verified_files = checksum_verification(sdk_root, version)
    
    # step 3: extract models.
    models_archive = [ j for j in verified_files if j.find("sdk_ZenidModels_")!=-1 ][0]
    install_models(sdk_root, models_archive)
    replace_models(sdk_root, project_root)

    # step 4: replace core lib.
    # LibZenid xcproject
    libzen_archive = [ j for j in verified_files if j.find("sdk_iOS_")!=-1 ][0]
    replace_sdk(sdk_root, project_root, libzen_archive)
    print()

# Parse parameters from input and run update process.
def main():
    parser = argparse.ArgumentParser(description='Extract and verify signature of ZenID SDK update.')
    parser.add_argument('path', metavar='path-to-downloaded-sdk', type=str,
                    help='Directory with Models.zip, signature.zip, ZenidMobileSdk.zip downloaded')
    parser.add_argument('version', metavar='sdk-version', type=str,
                    help='SDK version')
    parser.add_argument('project_path', metavar='project_path', type=str,
                    help='Directory with ZenID project')

    args = parser.parse_args()

    sdk_version = args.version
    sdk_root = args.path
    project_path = args.project_path

    process_update(sdk_root, project_path, sdk_version)


if __name__ == '__main__':
    main()
