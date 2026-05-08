// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

(() => {
    const mermaidUrl = 'https://cdn.jsdelivr.net/npm/mermaid@11.6.0/dist/mermaid.min.js';
    const mermaidIntegrity = 'sha384-zkWMJO4sgpPUzyuOgDx8HB/K55glbAwajEpk1Go2NWRuPkPA/wIhoEJTuSkmOYrV';
    const darkThemes = ['ayu', 'navy', 'coal'];
    const lightThemes = ['light', 'rust'];

    const classList = document.getElementsByTagName('html')[0].classList;

    let lastThemeWasLight = true;
    for (const cssClass of classList) {
        if (darkThemes.includes(cssClass)) {
            lastThemeWasLight = false;
            break;
        }
    }

    const loadMermaid = () => {
        if (window.mermaid) {
            return Promise.resolve();
        }

        return new Promise((resolve, reject) => {
            const script = document.createElement('script');
            script.src = mermaidUrl;
            script.integrity = mermaidIntegrity;
            script.crossOrigin = 'anonymous';
            script.onload = resolve;
            script.onerror = () => reject(new Error(`Failed to load Mermaid from ${mermaidUrl}`));
            document.head.appendChild(script);
        });
    };

    const renderMermaid = async () => {
        const theme = lastThemeWasLight ? 'default' : 'dark';
        window.mermaid.initialize({ startOnLoad: false, theme });
        await window.mermaid.run({ querySelector: '.mermaid' });
    };

    const reloadOnThemeChange = (themeIds, shouldReload) => {
        for (const themeId of themeIds) {
            const themeButton = document.getElementById(themeId);
            if (!themeButton) {
                continue;
            }

            themeButton.addEventListener('click', () => {
                if (shouldReload()) {
                    window.location.reload();
                }
            });
        }
    };

    loadMermaid().then(renderMermaid).catch((error) => {
        console.error(error);
    });

    // Simplest way to make Mermaid re-render diagrams in the new theme is via refreshing the page.
    reloadOnThemeChange(darkThemes, () => lastThemeWasLight);
    reloadOnThemeChange(lightThemes, () => !lastThemeWasLight);
})();
