/**
 * Simple console logger for ZenID iOS web visualizer
 */
const zenidLog = {
    error: (message, data) => {
        console.error('[ERROR]', message, data ?? '');
    },
    warn: (message, data) => {
        console.warn('[WARN]', message, data ?? '');
    },
    info: (message, data) => {
        console.info('[INFO]', message, data ?? '');
    },
    debug: (message, data) => {
        console.debug('[DEBUG]', message, data ?? '');
    }
};

export { zenidLog };