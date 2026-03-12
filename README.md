# Lightroom Analytics Dashboard

Ontdek de verborgen kennis in je Lightroom catalogus! Jouw `.lrcat` bestand is een schatkist vol data over je fotografie-gewoonten, uitrusting en workflow. Dit Lightroom Analytics Dashboard transformeert die ruwe database in prachtige, interactieve visualisaties, lokaal in je browser.

Maak afwegingen voor je volgende aankoop niet op onderbuikgevoel, maar op harde data: met welke sluitertijden werk je echt? Op welke exacte millimeter-stand schiet je het vaakst met je zoomlens? En welk diafragma levert procentueel de meeste 'Keepers' op?

---

## 🌟 Functionaliteiten

*   **Dashboard & Import:** Importeer je Lightroom Catalogus (`.lrcat`) veilig vanuit je dashboard. Het dashboard geeft je een breed historisch overzicht van je activiteit (foto's per maand).
*   **Explore:** Groepeer je fotografeer-sessies op basis van je gebruikte Camera(body) en je objectieven, in kleurrijke Pie en Doughnut charts.
*   **EXIF Analytics & Correlations:** Graaf diep in brandpuntsafstanden, diafragma en sluitertijden. De scatterplots tonen fascinerende combinaties (zoals ISO vs Sluitertijd). Shutter Speeds worden netjes omgezet van interne APEX-nummers naar de 1/250s notatie die je gewend bent.
*   **Hit Rates (Golden Combos):** Visuele overzichten (met twee Y-assen) om per EXIF-waarde te bepalen hoeveel van je totale foto's daadwerkelijk een 'Pick' (vlaggetje) ontvingen. Wat is jouw 'Golden Combo'?
*   **Quality & Edits:** Bekijk hoe je ster-beoordelingen (1 tot 5 sterren) zich verhouden. Daarbovenop zie je direct weke lenzen of camera's historisch gezien de *meeste* schuifjes in de ontwikkelaars-module vereisen. (Avg. Edit Count).
*   **Lens Profiles (Deep Zoom):** Kies een lens uit the dropdown en bekijk het unieke profiel. Val je tijdens het inzoomen telkens terug op the uitersten van je zoombereik? En welk diafragma druk je the vaakst in bij specifiek dit objectief?
*   **Lens Config:** Vaak herkent Lightroom objectieven onder cryptische namen of wisselende tekst-strings over de jaren heen. Op deze pagina kun je lenzen simpelweg 'groeperen' of hernoemen (bijv: "Mijn 50mm Prime") zodat al je grafieken zuiver blijven.

---

## 💻 Systeemvereisten

Dit project is gebouwd op Python in combinatie met een Flask lokale webserver en is volledig platform-onafhankelijk ontworpen. De filepicker opent native op zowel Windows als macOS.

*   **Besturingssysteem:** Windows, macOS, of Linux
*   **Python:** Versie 3.8 of nieuwer geïnstalleerd (zorg dat `python` aan je PATH is toegevoegd op Windows).
*   **Lightroom:** Een `.lrcat` bestand (Lightroom Classic Catalogus, SQLite-gebaseerd). Zorg ervoor dat foto's (althans tijdelijk) gesynchroniseerd / opgeslagen zijn, zodat de catalogus actueel is.

---

## 🛠 Installatie & Start-up

Volg deze stappen om het portaal op je computer te krijgen en op te starten.

### 1. Project Map Voorbereiden
Zorg dat je het project in een map op je computer hebt staan, bijvoorbeeld `Documenten/Lightroom Analytics`.
Open je command-line interface:
* Op Windows: Open **Opdrachtprompt (Command Prompt)** of **PowerShell**.
* Op macOS/Linux: Open de **Terminal**.

Navigeer naar deze map:
```bash
cd pad/naar/jouw/map/Lightroom
```

### 2. Dependencies Installeren
Je hebt Python modules nodig die niet standaard worden meegeleverd: **Flask** (voor de lokale webserver). Typ in je terminal/opdrachtprompt:

```bash
pip install Flask
```

### 3. De Applicatie Starten
Zodra Flask succesvol geïnstalleerd is, kan je de server aanzetten! Zorg ervoor dat je nog steeds in the juiste directory bent in je Terminal en typ:
```bash
python lightroom.py
```
*(Gebruik `python3 lightroom.py` op macOS/Linux)*

De Terminal zal bevestigen dat de server gestart is met een bericht dat op het volgende lijkt:
`* Running on http://127.0.0.1:5100/`

Laat dit Terminal/Command Prompt venster openstaan! (Als je het venster sluit, stopt de server).

---

## 🚀 Gebruikershandleiding

### 1. Openen in je Browser
Open je favoriete webbrowser (Safari, Chrome, Firefox) en ga naar the verschenen link uit je terminal:
**[http://127.0.0.1:5100/](http://127.0.0.1:5100/)**

### 2. Je Catalogus Importeren
Als dit the allereerste keer is dat je de app gebruikt (of als je na een maand fotograferen je statistieken wilt bijwerken), moet je de app eerst voeden:
1. Klik in het Dashboard op de imposante blauwe knop `"Select .lrcat File & Start Import"`.
2. Er zal zich een bestandsselectie-venster openen (Native Finder op Mac, File Explorer op Windows).
3. Navigeer naar je map met Lightroom bestanden en selecteer the `.lrcat` bestand.
4. Klik the 'Open' of 'Choose' knop.
5. De server gaat nu op volle toeren the benodigde data (Zonder the eigenlijke, ruwe foto's aan te raken) overhevelen naar een lokale `Ligthroom_dashboard.db` SQLite database. The originele `.lrcat` wordt op **read-only** wijze geopend, we overschrijven dus absoluut niks in jouw Lightroom structuur!
6. Als hij klaar is, herlaadt het Dashboard met jouw eerste grafieken.

### 3. Lenzen Configureren (Optioneel maar Aangeraden)
Vaak komen lenzen rommelig in exif data terecht (bijv. "FE 24-70mm F2.8 GM", "Sony FE 24-70mm..." etc).
Navigeer bovenin het hoofdmenu naar **"Lens Config"**.
1. De kolom links toont alle rauwe benamingen uit je catalogus met daarachter de hoeveelheid foto's.
2. Typt een makkelijk leesbare groepsnaam (Bijv. "Sony 24-70 G-Master") in de inputvakjes ernaast, *voor elke variatie* van dezelfde lens.
3. Klik op *Save Couplings*.
Alle grafieken op the Explore en Edits pagina respecteren nu deze vernieuwde groepen!

### 4. Spelen met de Filters!
Bijna elke pagina (behalve het dashboard en config) heeft bovenaan een **From Month** en **To Month** invoervak.
Pas deze de datums aan (bijv: "Januari 2022 tot en met December 2023"). Zodra je *buiten* het vakje klikt verversen alle (behalve de Pie-) grafieken op the pagina on the fly naar enkel data gehaald uit die precieze tijdsspanne. Mooi om per reisvakantie the zien hoe the apparatuur in The smaak viel!

---

## 🔒 Privacy & Lokale verwerking
Dit is een offline tool! Je `.lrcat` catalogus is The heilige graal van je Lightroom portfolio.
*   De Python app leest de data enkel **lokaal**.
*   Er worden géén gegevens, instellingen of foto-meta naar internet verstuurd.
*   De webinterface is enkel "zichtbaar" zolang jij de Python terminal open hebt staan op jouw eigen host adres (localhost / 127.0.0.1). 
*   Dit pakket zoekt in *geen enkel geval* je originele RAW foto's / .DNG's bestanden op jouw harde schijven op. The Analytics baseert zich 100% op the Lightroom `.lrcat` the jij selecteert.
