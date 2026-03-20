window.addEventListener('message', (event) => {
    if (event.data.type === 'openstore') {
        window.invokeNative("openUrl", "https://101.tebex.io/");
    }
});
