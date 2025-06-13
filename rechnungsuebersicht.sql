-- Rechnungsübersicht für JTL-Wawi
USE [eazybusiness];
GO

SELECT TOP (10000)
    r.cRechnungsNr AS Rechnungsnummer,
    r.dErstellt AS Rechnungsdatum,
    a.cAuftragsNr AS Auftragsnummer,
    k.cKundenNr AS Kundennummer,
    k.cEbayName AS Kundenname,
    r.cBezahlt AS BezahltStatus,
    r.cStatus AS Rechnungsstatus,
    SUM(p.fAnzahl * p.fVKNetto) AS RechnungsbetragNetto
FROM dbo.tRechnung r
LEFT JOIN Rechnung.tRechnungPosition p ON r.kRechnung = p.kRechnung
LEFT JOIN Verkauf.tAuftrag a ON r.tBestellung_kBestellung = a.kAuftrag
LEFT JOIN dbo.tkunde k ON a.kKunde = k.kKunde
GROUP BY 
    r.cRechnungsNr, r.dErstellt, a.cAuftragsNr, 
    k.cKundenNr, k.cEbayName, r.cBezahlt, r.cStatus
ORDER BY r.dErstellt DESC;
