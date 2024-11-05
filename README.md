
# Test Python

Diese GitHub-Action führt Tests für Python-Anwendungen aus und bietet eine Umgebung für wiederverwendbare Tests.

## Beschreibung

Diese Action führt Tests für Python-Projekte durch, die sich auf einem angegebenen Betriebssystem und einer bestimmten Python-Version ausführen lassen. Sie unterstützt auch die optionale Installation von FFMPEG und das Einrichten von Caching für Abhängigkeiten.

## Eingaben

| Name              | Beschreibung                                        | Erforderlich | Standardwert |
|-------------------|-----------------------------------------------------|--------------|--------------|
| `test_path`       | Der Pfad zu den zu testenden Dateien oder Verzeichnissen | Ja           | Keine        |
| `os`              | Das Betriebssystem, auf dem die Tests ausgeführt werden sollen | Ja           | Keine        |
| `py-version`      | Die Python-Version, die für die Tests verwendet wird | Ja           | Keine        |
| `ffmpeg-required` | Gibt an, ob FFMPEG installiert werden soll           | Ja           | Keine        |

## Verwendung

Erstellen Sie eine Workflow-Datei (z. B. `.github/workflows/test.yml`) und verwenden Sie diese Action wie folgt:

```yaml
name: Test Python Application

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ${{ inputs.os }}

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Test Python
        uses: platomo/test-python-app-action@main
        with:
          test_path: "src/"
          os: "ubuntu-latest"
          py-version: "3.9"
          ffmpeg-required: true
```

## Schritte im Workflow

1. **Checkout Repository**: Checkt den Code aus dem Repository aus.
2. **Installiere FFMPEG** (optional): Installiert FFMPEG, wenn `ffmpeg-required` auf `true` gesetzt ist.
3. **Set up Python**: Rüstet die angegebene Python-Version aus und aktiviert `pip`-Caching.
4. **Installiere Python-Abhängigkeiten**: Installiert die benötigten Abhängigkeiten basierend auf den `requirements.txt`- und `requirements-dev.txt`-Dateien (falls vorhanden).
5. **Linting**: Überprüft den Code mit `flake8` auf Formatierungsprobleme.
6. **Statische Typprüfung**: Führt eine Typprüfung mit `mypy` durch.
7. **Tests ausführen**: Führt Tests mit `pytest` aus und generiert eine Coverage für den angegebenen `test_path`.

## Erforderliche Berechtigungen

Diese Action benötigt Zugriffsrechte auf den Quellcode, um die Tests, Linting und Typprüfung durchzuführen.
