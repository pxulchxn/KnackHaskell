# KnackHaskell
<div id="top"></div>


<!-- PROJECT LOGO -->
<br />
<div align="center">
<h3 align="center">Knack in Haskell</h3>

  <p align="center">
    Dieses Projekt ist im Zeitraum von September bis Dezember 2021 im Modul "Weitere Programmiersprache" entstanden. Hierbei haben wir in der Programmiersprache Haskell das Kartenspiel Knack oder auch bekannt als Schwimmen implementiert.
    <br />
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#regeln">Regeln</a>
      <ul>
        <li><a href="#allgemeines">Allgemeines</a></li>
        <li><a href="#karten">Karten</a></li>
        <li><a href="#wertigkeit-der-kartentypen">Wertigkeit der Kartentypen</a></li>
        <li><a href="#ablauf">Ablauf</a></li>
        <li><a href="#besonderheiten">Besonderheiten</a></li>
        <li><a href="#spielende">Spielende</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Regeln

### Allgemeines

* es wird mit 32 Karten gespielt (Skatblatt)
* 2-7 Spieler
<br />Ziel: Nicht die geringste Punktezahl haben.


<p align="right">(<a href="#top">back to top</a>)</p>

### Karten

* Karo
* Kreuz
* Pik
* Herz

<p align="right">(<a href="#top">back to top</a>)</p>

### Wertigkeit der Kartentypen

Karte | Wertigkeit
:---: | :---:
Ass | 11
Zehn | 10
Koenig | 10
Dame | 10
Bube | 10
Neun | 09
Acht | 08
Sieben | 07

<p align="right">(<a href="#top">back to top</a>)</p>

### Ablauf

* jeder Spieler erhält zu Beginn einen Kartenstapel bestehend aus 3 Karten
* der Karten-Ausgeber teilt sich selbst 2 Kartenstapel aus
    * wählt sich einen aus, welchen er angucken darf
    * anschließend entscheiden, ob er diesen behalten möchte oder auf "gut Glück" den anderen wählen (ohne anzuschauen)
* wenn ein Spieler an der Reihe ist, kann er entweder eine einzige Karte wählen, alle drei Karten oder gar keine (hierbei gibt es zwei Varianten)
    * wählt ein Spieler keine Karte, so kann er "schieben" (eine Runde aussetzen) oder "zumachen" (das Spiel in der nächsten Runde beenden (erst ab Runde 2 möglich))

<p align="right">(<a href="#top">back to top</a>)</p>

### Besonderheiten

* Feuer/Blitz:
    * drei gleichranige Karten zählen im Allgemeinen 30,5 Punkte
    * drei Asse sind ein "Super-Knack" und gewinnen immer
* schieben alle Spieler, so werden 3 neue Karten in die Mitte gelegt
* liegt in der Mitte eine Kombination aus 7/8/9, so werden 3 neue Karten in die Mitte gelegt

<p align="right">(<a href="#top">back to top</a>)</p>

### Spielende

* Spiel wird beendet, wenn ein Spieler zumacht, jedoch dürfen die anderen Spieler nochmal eine Runde weiterspielen
* Knack oder Super-Knack, so wird das Spiel sofort beendet

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ---------------------------------------------------------------- GETTING STARTED ---------------------------------------------------------------- -->
## Getting Started

Hier beschreiben wir, wie dieses Programm lokal ausführbar gemacht werden kann.

### Installation Haskell und Visual Studio Code (Windows)

1. Eingabeaufforderung (cmd) als Admin ausführen
  <a href="https://github.com/github_username/repo_name">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/github_username/repo_name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [] Feature 1
- [] Feature 2
- [] Feature 3
    - [] Nested Feature

See the [open issues](https://github.com/github_username/repo_name/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com

Project Link: [https://github.com/github_username/repo_name](https://github.com/github_username/repo_name)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
