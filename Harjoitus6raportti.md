# Palvelin hallinta harjoitus 6 - Oman moduulin tekeminen ja sen testaaminen.

Tämä moduuli on osa Tero Karvisen Palvelinten Hallinta-kurssia. [Tästä linkistä pääset tehtäviin.](http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-4-ti-5-ke-5-loppukevat-2018-5p#h6)

Harjoituksessa käyttämäni kone on MSI:n GX 640 (64-bit) kannettava tietokone ja koneeseen on asennettu käyttöjärjestelmäksi Linux Xubuntu 16.04.3 LTS (64-bit).

Teen nämä harjoitukset aiemmin luomallani live-tikulla. Voit saada oman Xubuntu 16.04.3 LTS (64-bit) versiosi [täältä.](http://torrent.ubuntu.com/xubuntu/releases/xenial/release/desktop/xubuntu-16.04.4-desktop-amd64.iso.torrent)

## a) Kultainen polku. Tee ensimmäinen versio modulistasi, joka toimii ainakin optimiolosuhteissa. Jos jokin säätö on poikkeuksellisen hankala, voit tehdä sen tässä versiossa käsin, ja dokumentoida ajamasi käskyt. 

Aikaisemmin valitsemani aihe Logstashin ja tarvittavien lisäosien asentamisesta sekä konfiguroinnista osoittautui liian haasteelliseksi omille 
taidoilleni, joten vaihdoin moduulini aiheen sellaiseksi, jota voisin itse käyttää tulevaisuudessa ja tarvittaessa muokata siihen lisäominaisuuksia.
Moduulini siis asentaa minulle tarpeellisia ohjelmia, kuten Vlc, Blender ja Shutter. Näiden lisäksi se asentaa Apachen ja siihen tarvittavan PHP-kirjaston,
sekä SSH:n ja muokkaa sen oletusportin toiseksi.

Aloitin koko työn puhtaalta pöydältä MSI:n GX 640 (64-bit) kannettavalla tietokoneellani, käyttäen Xubuntu 16.04.3 LTS-livetikkua.

### Kannettavan valmistelu

Aloitetaan avaamalla terminaali ja vaihdetaan näppäimistön kieli Suomeksi seuraavalla komennolla.
 
	$ setxkbmap fi

Tämän jälkeen kirjauduin Wifi-verkkooni, jotta pääsen etenemään terminaalissa. Yhteyden saatuani päivitän ja asennan tarvittavat 
paketit seuraavilla komennoilla.

	$ sudo apt-get update
	$ sudo apt-get -y install git salt-minion salt-master

Tämän jälkeen yhdistin minionin masteriin ja poistan samalla turhan file_ignore_glob: virheilmoituksen seuraavilla komennoilla.

	$ sudoedit /etc/salt/minion [Lisätään tänne rivi: master: ip-osoite]
	$ sudoedit /etc/salt/master [Lisätään tänne rivi: file_ignore_glob [] ]

Tämän jälkeen käynnistämme minionin ja masterin uudelleen seuraavilla komennoilla.

	$ sudo systemctl restart salt-minion.service
	$ sudo systemctl restart salt-master.service

Seuraavaksi tarkastetaan onko master saanut uuden minionin avaimen hyväksyttäväksi, jos on hyväksymme sen. Se tapahtuu seuraavilla 
komennoilla.

	$ sudo salt-key
	
	Accepted Keys:
	Denied Keys:
	Unaccepted Keys:
	xubuntu
	Rejected Keys:

	$ sudo salt-key -A
	
	The following keys are going to be accepted:
	Unaccepted Keys:
	xubuntu
	Proceed? [n/Y] y
	Key for minion xubuntu accepted.

Seuraavaksi voimmekin kokeilla saimmeko yhteyden minionin ja masterin välille. Tämä onnistuu seuraavalla komennolla.

	$ sudo salt '*' test.ping

	xubuntu:
	    True

### Tilan luominen ja sen siirto Githubiin.

Tämän jälkeen voimme aloittaa tilan luomisen. Aloitamme luomalla ensin salt-kansion /srv-kansion sisälle. Muistetaan kuitenkin
jokaisen kohdan jälkeen testata lisätty osa. En tehnyt näin aluksi ja sain kärsiä tästä päätöksestä jolloin oli helpompi aloittaa alusta.
Jokaisen asennettavan demonin kansion täytyy sisältää init.sls-tiedosto. Aloitin luomalla apache kansion, jonka sisälle tulivat [init.sls](https://github.com/villetouronen/Module/blob/05b35586a238f057bd671f855b7fa40043e47a74/srv/salt/apache/init.sls) 
ja [index.php.](https://github.com/villetouronen/Module/blob/05b35586a238f057bd671f855b7fa40043e47a74/srv/salt/apache/index.php) Tämän jälkeen yksittäinen testaus onnistuu seuraavalla tavalla.

	$ sudo salt '*' state.apply apache

Tilan ajo onnistui, joten voimme siirtyä seuraavaan tilaan. Sama tapa jatkuu kunnes kaikki tarvittavat demonit ja niihin liitettävät tiedostot on luotu.
Lopuksi luomme salt-kansion sisälle top.sls-tiedoston, joka näyttää [tältä.](https://github.com/villetouronen/Module/blob/05b35586a238f057bd671f855b7fa40043e47a74/srv/salt/top.sls)
Seuraavaksi voimme testata koko moduulin toiminnan seuraavalla komennolla.

	$ sudo salt '*' state.highstate

Ajo onnistui, joten voimme siirtää kaiken salt-kansion sisälle luomamme sisällön repositoryyn. Jos ette ole vielä luoneet aikaisemmin repositorya, [löydät
ohjeet siihen täältä.](http://terokarvinen.com/2016/publish-your-project-with-github) Muista kuitenkin luodessasi repositorya luoda sinne samalla README.md tiedosto ja valita moduulillesi sopiva lisenssi.
Siirto tähän repositoryyn onnistuu seuraavalla komennolla.

	$ sudo mv salt/ /home/xubuntu/Module/srv/

Tämän jälkeen voit käyttää edellisessä harjoituksessa käyttämiäni komentoja, jotta saat siirrettyä moduulin Githubin suojiin. 
[Nämä komennot löydät täältä.](https://github.com/villetouronen/Harjoitus5/blob/master/README.md)
    
Seuraavaksi loin vielä tuonne moduulin juureen kaksi bash scriptiä. Toinen scripteistä ajaa moduulin paikallisesti ja se näyttää kutakuinkin tältä.

	sudo salt-call --local state.highstate --file-root srv/salt

Toinen scripti taas valmistelee ajettavan kohteen valmiiksi moduulin ajoa varten ja lopuksi suorittaa tuon edellisen scriptin. Käytin tässä scriptissä
pohjana Tero Karvisen sirotinta, joka löytyy seuraavasta osoitteesta: 
[https://github.com/terokarvinen/sirotin/blob/master/run.sh] Oma scriptini näyttää seuraavalta.

	#!/bin/bash
	# Original by Tero Karvinen Copyright 2018 Tero Karvinen http://TeroKarvinen.com GPL 3
	# Github: https://github.com/terokarvinen/sirotin/blob/master/run.sh
	
	setxkbmap fi
	sudo apt-get update
	sudo apt-get -y install git salt-minion
	sudo timedatectl set-timezone Europe/Helsinki
	
	echo 'master: localhost'|sudo tee /etc/salt/minion
	git clone https://github.com/villetouronen/Module
	cd Module/
	bash module.sh

Nyt olen valmis testaamaan tätä tyhjällä livetikkua käyttävällä koneella.

## b) Kokeile moduuliasi tyhjässä koneessa. Voit käyttää virtualboxia, vagranttia tai livetikkua.

Kun olemme saaneet käynnistettyä koneen livetikun avulla, avaamme terminaalin ja syötämme sinne seuraavan komennon.

	$ wget https://raw.githubusercontent.com/villetouronen/Module/master/moduletest.sh

Tämä lataa tuon repositoryn sisällön koneelle, jonka jälkeen voimme suorittaa tuon viimeksi luomamme scriptin seuraavalla komennolla.

	$ bash moduletest.sh

Tämä vaihe kestää kauan, koska se asentaa monia ohjelmia, mutta kärsivällisen odottelun jälkeen antaa positiivisen palautteen.

	Summary for local
	-------------
	Succeeded: 15 (changed=15)
	Failed:     0
	-------------
	Total states run:      15

Eli lopulta saimme moduulin toimimaan ja asensimme sen pelkästään kahta komentoa käyttäen.

	$ wget https://raw.githubusercontent.com/villetouronen/Module/master/moduletest.sh
	$ bash moduletest.sh

Liitän vielä lopuksi linkin kuvaan jossa näkyy jokainen asennettu ohjelma, jolla on graafinen käyttöliittymä.

	[]	
 
## c) Käyttäjätarina (user story): ketkä ovat modulisi käyttäjät? Mitä he haluavat saada aikaan modulillasi? Missä tilanteessa he sitä käyttävät? Mitkä ovat tärkeimmät parannukset käyttäjän kannalta, joita moduliin pitäisi vielä tehdä? Tähän c-kohtaan vain sanallinen vastaus, tämä kohta ei poikkeuksellisesti edellytä testejä tietokoneella.

Ajattelin tämän moduulin tulevan enemmän omaan käyttöön, koska siinä on mukana ohjelmia joita tarvitsen usein. Työskentelyni nopeutuu huomattavasti, kun voin 
käyttää tätä moduulia myös livetikulla. Tulevaisuudessa ajattelin vielä parannella moduulia ja lisätä siihen ohjelmia, jotka ovat minulle hyödyllisiä. Tällä 
hetkellä moduuli kuitenkin toimii omasta mielestäni hyvin.
