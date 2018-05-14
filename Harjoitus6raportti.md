# Palvelin hallinta harjoitus 6 - Oman moduulin tekeminen ja sen testaaminen.

Tämä moduuli on osa Tero Karvisen Palvelinten Hallinta-kurssia. [Tästä linkistä pääset tehtäviin.](http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-4-ti-5-ke-5-loppukevat-2018-5p#h6)

Harjoituksessa käyttämäni kone on MSI:n GX 640 (64-bit) kannettava tietokone ja koneeseen on asennettu käyttöjärjestelmäksi Linux Xubuntu 16.04.3 LTS (64-bit).

Teen nämä harjoitukset aiemmin luomallani live-tikulla. Voit saada oman Xubuntu 16.04.3 LTS (64-bit) versiosi [täältä.](http://torrent.ubuntu.com/xubuntu/releases/xenial/release/desktop/xubuntu-16.04.4-desktop-amd64.iso.torrent)

## a) Kultainen polku. Tee ensimmäinen versio modulistasi, joka toimii ainakin optimiolosuhteissa. Jos jokin säätö on poikkeuksellisen hankala, voit tehdä sen tässä versiossa käsin, ja dokumentoida ajamasi käskyt. (Valmis moduli tarvitaan vasta esitykseen ensi viikolla).

Aikaisemmin valitsemani aihe Logstashin ja tarvittavien lisäosien asentamisesta sekä konfiguroinnista osoittautui liian haasteelliseksi omille 
taidoilleni, joten vaihdoin moduulini aiheen sellaiseksi, jota voisin itse käyttää tulevaisuudessa ja tarvittaessa muokata siihen lisäominaisuuksia.
Moduulini siis asentaa minulle tarpeellisia ohjelmia, kuten Vlc, Blender ja Shutter. Näiden lisäksi se asentaa Apachen ja siihen tarvittavan PHP-kirjaston,
sekä SSH:n ja muokkaa sen oletusportin toiseksi.

## b) Kokeile moduliasi tyhjässä koneessa. Voit käyttää virtualboxia, vagranttia tai livetikkua.




## c) Käyttäjätarina (user story): ketkä ovat modulisi käyttäjät? Mitä he haluavat saada aikaan modulillasi? Missä tilanteessa he sitä käyttävät? Mitkä ovat tärkeimmät parannukset käyttäjän kannalta, joita moduliin pitäisi vielä tehdä? Tähän c-kohtaan vain sanallinen vastaus, tämä kohta ei poikkeuksellisesti edellytä testejä tietokoneella.

Ajattelin tämän moduulin tulevan enemmän omaan käyttöön, koska siinä on mukana ohjelmia joita tarvitsen usein. Työskentelyni nopeutuu huomattavasti, kun voin 
käyttää tätä moduulia myös livetikulla. Tulevaisuudessa ajattelin vielä parannella moduulia ja lisätä siihen ohjelmia, jotka ovat minulle hyödyllisiä. Tällä 
hetkellä moduuli kuitenkin toimii omasta mielestäni hyvin.
