# Lightroom Analytics Dashboard

Discover the hidden knowledge inside your Lightroom catalog! Your `.lrcat` file is a treasure trove of data about your photography habits, equipment, and workflow. This Lightroom Analytics Dashboard transforms that raw database into beautiful, interactive visualizations, locally in your web browser.

Stop making decisions for your next gear purchase based on gut feeling, but base them on hard data: what shutter speeds do you actually use? At exactly what millimeter mark do you shoot most often with your zoom lens? And which aperture yields the highest percentage of 'Keepers'?

---

## 🌟 Features

*   **Dashboard & Import:** Safely import your Lightroom Catalog (`.lrcat`) from your dashboard. The dashboard gives you a broad historical overview of your activity (photos per month).
*   **Explore:** Group your photography sessions based on the Camera (body) and lenses you used, visualized in colorful Pie and Doughnut charts.
*   **EXIF Analytics & Correlations:** Dig deep into focal lengths, apertures, and shutter speeds. The scatter plots reveal fascinating combinations (like ISO vs Shutter Speed). Shutter Speeds are neatly converted from internal APEX values back to the familiar `1/250s` notation.
*   **Hit Rates (Golden Combos):** Visual overviews (featuring dual Y-axes) to determine exactly how many of your total photos actually received a 'Pick' (flag) per EXIF value. What is your 'Golden Combo'?
*   **Quality & Edits:** See how your star ratings (1 to 5 stars) are distributed. On top of that, you can instantly see which lenses or cameras historically require the *most* slider adjustments in the develop module (Avg. Edit Count).
*   **Lens Profiles (Deep Zoom):** Pick a lens from the dropdown and view its unique profile. Do you constantly fall back on the extremes of your zoom range when zooming? And which aperture do you press most often for this specific lens?
*   **Lens Config:** Lightroom often recognizes lenses under cryptic names or varying text strings over the years. On this page, you can easily 'group' or rename lenses (e.g., "My 50mm Prime") so that all your charts stay clean and accurate.
*   **Bilingual Interface:** Seamlessly switch between an English (🇬🇧 EN) and Dutch (🇳🇱 NL) interface using the toggle at the top to match your preference!
*   **Dark Mode Ready:** The interface, including date pickers, works seamlessly with 'Dark Mode' in Chromium-based browsers (Chrome, Edge, Brave).

---

## 💻 System Requirements

This project is built on Python combined with a local Flask web server and is designed to be completely platform-independent. The file picker opens the native dialog on both Windows and macOS.

*   **Operating System:** Windows, macOS, or Linux
*   **Python:** Version 3.8 or newer installed (ensure `python` is added to your PATH on Windows).
*   **Lightroom:** An `.lrcat` file (Lightroom Classic Catalog, SQLite-based). Ensure that your photos are synced/saved (at least temporarily) so the catalog is up-to-date.

---

## 🛠 Installation & Start-up

Follow these steps to get the portal running on your computer.

### 1. Prepare Project Folder
Make sure the project is located in a folder on your computer, for example `Documents/Lightroom Analytics`.
Open your command-line interface:
* On Windows: Open **Command Prompt** or **PowerShell**.
* On macOS/Linux: Open the **Terminal**.

Navigate to this folder:
```bash
cd path/to/your/Lightroom/folder
```

### 2. Install Dependencies
You'll need a couple of Python modules that aren't included by default: **Flask** (for the local web server). Type this in your terminal/command prompt:

```bash
pip install Flask
```

### 3. Start the Application
Once Flask is successfully installed, you can turn on the server! Ensure you are still in the correct directory in your Terminal and type:
```bash
python lightroom.py
```
*(Use `python3 lightroom.py` on macOS/Linux)*

The Terminal will confirm the server has started with a message similar to this:
`* Running on http://127.0.0.1:5100/`

Leave this Terminal/Command Prompt window open! (If you close the window, the server will stop).

### 4. Running via Docker (Optional)
If you prefer not to install Python on your local system, you can run the app using Docker.
1. Ensure **Docker** (and Docker Compose) are installed.
2. Copy your complete Lightroom catalog (the `.lrcat` file) into the new `import/` folder inside the project directory:
   ```bash
   cp path/to/your_catalog.lrcat ./import/
   ```
3. Start the container in the background:
   ```bash
   docker-compose up -d
   ```
4. The app is now running on `http://127.0.0.1:5100/`. *Note: Because a Docker container cannot physically browse your Mac/Windows files, the native "Browse" file picker button will be replaced by a manual input field. Enter `/app/import/your_catalog.lrcat` here.*

The processed data is stored safely and persistently in the `./data/` folder on your own hard drive.

---

## 🚀 User Manual

### 1. Open in your Browser
Open your favorite web browser (Safari, Chrome, Firefox) and go to the link that appeared in your terminal:
**[http://127.0.0.1:5100/](http://127.0.0.1:5100/)**

### 2. Import your Catalog
If this is the very first time you use the app (or if you want to update your statistics after a month of shooting), you need to feed the app first:
1. On the Dashboard, click the prominent blue button `"Select .lrcat File & Start Import"`.
2. A file selection window will open (Native Finder on Mac, File Explorer on Windows).
3. Navigate to your Lightroom files folder and select the `.lrcat` file.
4. Click the 'Open' or 'Choose' button.
5. The server will now run at full speed to transfer the necessary data (Without touching the actual, raw photos) into a local `Lightroom_dashboard.db` SQLite database. The original `.lrcat` is opened in **read-only** mode, so we absolutely do not overwrite anything in your Lightroom structure!
6. When it's finished, the Dashboard will reload with your first charts.

### 3. Configure Lenses (Optional but Recommended)
Lenses often end up messy in exif data (e.g., "FE 24-70mm F2.8 GM", "Sony FE 24-70mm..." etc).
Navigate to **"Lens Config"** in the main menu at the top.
1. The left column shows all the raw names from your catalog, followed by the number of photos.
2. Type an easily readable group name (e.g., "Sony 24-70 G-Master") in the input boxes next to it, *for every variation* of the same lens.
3. Click on *Save Couplings*.
All charts on the Explore and Edits page will now respect these new groups!

### 4. Play with the Filters!
Almost every page (except the dashboard and config) has filters for **Months**, **Camera**, and **Lens** at the top.
Adjust these filters (e.g., select a specific camera body or lens and a date range). As soon as you change a value, all charts on the page (except Pie charts) will refresh on the fly to show only data corresponding to those filters. Great for seeing how your gear performed on a specific holiday trip or with a specific lens!

---

## 🔒 Privacy & Local Processing
This is an offline tool! Your `.lrcat` catalog is the holy grail of your Lightroom portfolio.
*   The Python app only reads the data **locally**.
*   No data, settings, or photo metadata are ever sent to the internet.
*   The web interface is only "visible" as long as you keep the Python terminal open on your own host address (localhost / 127.0.0.1). 
*   Under *no circumstances* does this package look up your original RAW photos / .DNG files on your hard drives. The Analytics are 100% based on the Lightroom `.lrcat` file that you select.
