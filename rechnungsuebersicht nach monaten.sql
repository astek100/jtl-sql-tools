/*
------------------------------------------------------------
 JTL-Wawi SQL: Rechnungsübersicht nach Monaten
------------------------------------------------------------

Diese Abfrage fasst die Rechnungen nach Jahr und Monat zusammen
und gibt die Anzahl sowie die Netto-Summe pro Monat aus.
Die Sortierung erfolgt absteigend, sodass die neuesten Monate
zuerst erscheinen.
*/

-- Monatsübersicht der Rechnungen
USE [eazybusiness];
GO

SELECT
    YEAR(r.dErstellt) AS Jahr,
    MONTH(r.dErstellt) AS Monat,
    COUNT(*) AS AnzahlRechnungen,
    SUM(p.fAnzahl * p.fVKNetto) AS GesamtNetto
FROM dbo.tRechnung r
LEFT JOIN Rechnung.tRechnungPosition p
    ON r.kRechnung = p.kRechnung
GROUP BY
    YEAR(r.dErstellt),
    MONTH(r.dErstellt)
ORDER BY
    Jahr DESC,
    Monat DESC;
