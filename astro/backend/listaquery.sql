/*
Questo file contiene solo le query più importanti e complesse, non è quindi un elenco completo.
Per info aggiuntive domandare al back-end dev.
*/

-- QUERY HOME

-- BEST PHOTO

SELECT *
FROM foto JOIN fotobyrank ON foto.idfoto=fotobyrank.idfoto;

-- attività

$att_studi= SELECT studia.idstudio,studia.titolo,studia.evento,studia.inizio,studia.datainserimento,
                   astrofilo.username,astrofilo.nome,astrofilo.cognome,astrofilo.imgprofilo
            FROM studia JOIN relazioni ON studia.astrofilo=relazioni.astro2 JOIN astrofilo ON studia.astrofilo=astrofilo.mail
            WHERE relazioni.astro1=$usermail;

$att_foto= SELECT foto.idfoto,foto.immagine,foto.titolo,foto.idastrofilo,astrofilo.username
           FROM foto JOIN relazioni ON foto.idastrofilo=relazioni.astro2 JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
           WHERE relazioni.astro1=$usermail AND foto.idastrofilo IS NOT NULL;


-- pagina studio singolo

$data_studio= SELECT studia.*,astrofilo.username,astrofilo.imgprofilo
              FROM studia JOIN astrofilo ON studia.idastrofilo=astrofilo.mail
              WHERE studia.idstudio=$idst;

$foto_studio= SELECT *
              FROM foto
              WHERE idstudio=$idst;

$commenti_studio= SELECT astrofilo.username,astrofilo.imgprofilo,commentastudio.commento,commentastudio.datainserimento
                  FROM commentastudio JOIN astrofilo ON commentastudio.astrofilo=astrofilo.mail
                  WHERE commentastudio.studio=$idst
                  ORDER BY commentastudio.datainserimento DESC;

$rank_studio= SELECT SUM(voto) AS rank
              FROM giudicastudio
              WHERE studio=$idst;

-- pagina foto singola

$data_foto= SELECT foto.*,astrofilo.username,astrofilo.imgprofilo
            FROM foto JOIN astrofilo ON foto.idastrofilo=astrofilo.mail
            WHERE foto.idastrofilo IS NOT NULL;

commenti_foto= SELECT astrofilo.username,astrofilo.imgprofilo,commentafoto.commento,commentafoto.datainserimento
               FROM commentafoto JOIN astrofilo ON commentafoto.astrofilo=astrofilo.mail
               WHERE commentafoto.studio=$idft
               ORDER BY commentafoto.datainserimento DESC;

rank_foto= SELECT SUM(voto) AS rank
           FROM giudicafoto
           WHERE idfoto=$idft;
