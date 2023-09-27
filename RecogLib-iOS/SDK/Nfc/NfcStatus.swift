/// Nfc reading status reported back to the SDK
public enum NfcStatus: Int {
    /// Device does not support NFC
    case DEVICE_DOES_NOT_SUPPORT_NFC = 0
    /// We cannot connect to device with provided NFC key
    case INVALID_NFC_KEY = 1
    /// User of the wrapper skipped the NFC reading on purpose
    case USER_SKIPPED = 2
    /// NFC data successfully readed
    case OK = 3
}
