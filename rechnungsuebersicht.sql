/*
------------------------------------------------------------
 JTL-Wawi SQL: Rechnungsübersicht (mit Kunden und Summen)
------------------------------------------------------------

Diese Abfrage zeigt bis zu 10.000 Rechnungen aus der JTL-Wawi-Datenbank `eazybusiness`.
Sie enthält folgende Informationen:

- Rechnungsnummer
- Erstellungsdatum der Rechnung
- Zugehörige Auftragsnummer
- Kundennummer & Kundenname (aus cEbayName)
- Zahlungsstatus der Rechnung (Y/N)
- Rechnungsstatus
- Gesamtsumme der Rechnung (berechnet aus fVKNetto × Menge)

Voraussetzung:
- Du musst mit SQL Server Management Studio (SSMS) verbunden sein
- Die Datenbank `eazybusiness` muss aktiv sein

So verwendest du die Abfrage:
1. Öffne SSMS
2. Wähle links die Datenbank `eazybusiness`
3. Kopiere den gesamten SQL-Text in das Abfragefenster
4. Führe die Abfrage mit [F5] aus

Optional:
- Filter für offene Rechnungen: WHERE r.cBezahlt = 'N'
- Zeitraum einschränken: z. B. r.dErstellt >= '2025-01-01'
*/

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
