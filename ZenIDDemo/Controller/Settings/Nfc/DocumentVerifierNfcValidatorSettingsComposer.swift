import RecogLib_iOS

struct DocumentVerifierNfcValidatorSettingsComposer {
    func compose() -> DocumentVerifierNfcValidatorSettings {
        let config = ConfigServiceComposer.compose().load()
        if config.isNfcEnabled {
            let _ = RecogLib_iOS.selectProfile("NFC")
        } else {
            let _ = RecogLib_iOS.selectProfile("")
        }
        let verifier = DocumentVerifier(role: nil, country: nil, page: nil, code: nil, language: .Czech)
        return verifier.getNfcValidatorSettings()
    }
}
