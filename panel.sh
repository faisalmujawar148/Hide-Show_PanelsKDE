#!/bin/bash

# Get the current hiding status of the panel
panel_stat=$(qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "print(JSON.stringify(panels()[0], null, 4))" | grep '"hiding"')

# Print the exact panel status for debugging
echo "Panel status: $panel_stat"

# Check if the panel is in "none" hiding mode
if [[ "$panel_stat" == *'"hiding": "none"'* ]]; then
    echo "Panel is in 'none' mode, switching to 'autohide'"
    # Set panel to autohide
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.hiding = 'autohide';"
    sleep 1  # Wait 1 second to let the panel update

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.height = '-1';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.lengthMode = 'custom';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.minimumLength = '-10';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.length = '0';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.offset = '-1000';"
else
    echo "Panel is not in 'none' mode, setting to 'none'"
    # Set panel to always visible (none)
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.height = '22';"
    sleep 1  # Wait 1 second to let the panel update

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.lengthMode = 'fill';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.minimumLength = '1327';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.offset = '1000';"
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "p = panelById(panelIds[0]); p.hiding = 'none';"
    sleep 1  # Wait 1 second to let the panel update
fi
