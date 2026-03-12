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
*   **Lens Profiles (Deep Zoom):** Kies een lens uit de dropdown en bekijk het unieke profiel. Val je tijdens het inzoomen telkens terug op de uitersten van je zoombereik? En welk diafragma druk je het vaakst in bij specifiek dit objectief?
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
Zodra Flask succesvol geïnstalleerd is, kan je de server aanzetten! Zorg ervoor dat je nog steeds in de juiste directory bent in je Terminal en typ:
```bash
python lightroom.py
```
*(Gebruik `python3 lightroom.py` op macOS/Linux)*

De Terminal zal bevestigen dat de server gestart is met een bericht dat op het volgende lijkt:
`* Running on http://127.0.0.1:5100/`

Laat dit Terminal/Command Prompt venster openstaan! (Als je het venster sluit, stopt de server).

### 4. Uitvoeren via Docker (Optioneel)
Als je liever geen Python op je eigen systeem installeert, kun je de app via Docker draaien.
1. Zorg dat je **Docker** (en Docker Compose) geïnstalleerd hebt.
2. Kopieer je complete Lightroom catalogus (het `.lrcat` bestand) naar de nieuwe `import/` map in the projectdirectory:
   ```bash
   cp pad/naar/jouw_catalogus.lrcat ./import/
   ```
3. Start de container op de achtergrond:
   ```bash
   docker-compose up -d
   ```
4. De app draait nu op `http://127.0.0.1:5100/`. *Let op: Omdat een Docker container niet fysiek door jouw Mac/Windows bestanden kan bladeren, zal de native "Browse" filepicker knop vervangen worden door een handmatig invoerveld. Vul hier `/app/import/jouw_catalogus.lrcat` in.*

De verwerkte data wordt veilig en persistent opgeslagen in de map `./data/` op je eigen hardeschijf.

---

## 🚀 Gebruikershandleiding

### 1. Openen in je Browser
Open je favoriete webbrowser (Safari, Chrome, Firefox) en ga naar de verschenen link uit je terminal:
**[http://127.0.0.1:5100/](http://127.0.0.1:5100/)**

### 2. Je Catalogus Importeren
Als dit de allereerste keer is dat je de app gebruikt (of als je na een maand fotograferen je statistieken wilt bijwerken), moet je de app eerst voeden:
1. Klik in het Dashboard op de imposante blauwe knop `"Select .lrcat File & Start Import"`.
2. Er zal zich een bestandsselectie-venster openen (Native Finder op Mac, File Explorer op Windows).
3. Navigeer naar je map met Lightroom bestanden en selecteer het `.lrcat` bestand.
4. Klik op de 'Open' of 'Choose' knop.
5. De server gaat nu op volle toeren de benodigde data (Zonder de eigenlijke, ruwe foto's aan te raken) overhevelen naar een lokale `Ligthroom_dashboard.db` SQLite database. De originele `.lrcat` wordt op **read-only** wijze geopend, we overschrijven dus absoluut niks in jouw Lightroom structuur!
6. Als hij klaar is, herlaadt het Dashboard met jouw eerste grafieken.

### 3. Lenzen Configureren (Optioneel maar Aangeraden)
Vaak komen lenzen rommelig in exif data terecht (bijv. "FE 24-70mm F2.8 GM", "Sony FE 24-70mm..." etc).
Navigeer bovenin het hoofdmenu naar **"Lens Config"**.
1. De kolom links toont alle rauwe benamingen uit je catalogus met daarachter de hoeveelheid foto's.
2. Typt een makkelijk leesbare groepsnaam (Bijv. "Sony 24-70 G-Master") in de inputvakjes ernaast, *voor elke variatie* van dezelfde lens.
3. Klik op *Save Couplings*.
Alle grafieken op de Explore en Edits pagina respecteren nu deze vernieuwde groepen!

### 4. Spelen met de Filters!
Bijna elke pagina (behalve het dashboard en config) heeft bovenaan een **From Month** en **To Month** invoervak.
Pas deze datums aan (bijv: "Januari 2022 tot en met December 2023"). Zodra je *buiten* het vakje klikt verversen alle (behalve de Pie-) grafieken op de pagina on the fly naar enkel data gehaald uit die precieze tijdsspanne. Mooi om per reisvakantie te zien hoe de apparatuur in de smaak viel!

---

## 🔒 Privacy & Lokale verwerking
Dit is een offline tool! Je `.lrcat` catalogus is de heilige graal van je Lightroom portfolio.
*   De Python app leest de data enkel **lokaal**.
*   Er worden géén gegevens, instellingen of foto-meta naar internet verstuurd.
*   De webinterface is enkel "zichtbaar" zolang jij de Python terminal open hebt staan op jouw eigen host adres (localhost / 127.0.0.1). 
*   Dit pakket zoekt in *geen enkel geval* je originele RAW foto's / .DNG's bestanden op jouw harde schijven op. De Analytics baseert zich 100% op de Lightroom `.lrcat` die jij selecteert.
