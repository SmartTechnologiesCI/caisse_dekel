profile "Super Admin"
{
    Description = 'SUPER_ADMIN';
    CaptionML = ENU = 'Super Admin', FRA = 'Super Admin';
    RoleCenter = "Super Admin RoleCenter";
}
page 70173 "Super Admin RoleCenter"
{
    // Combine les profils "Caisse" (Page 70015 "Caisse RoleCenter"), "Bookkeepe_DA Role Center DEKEL"
    // (Page 50049, Caption FRA "Comptable DA"), "Création ticket" (Page 50129 "Creation ticket")
    // et "IT DEKEL" (Page 50130 "IT DEKEL Role Center") en un seul profil "Super Admin". Les actions
    // ci-dessous sont reprises telles quelles des Role Centers d'origine (une seule occurrence de
    // chaque area, puisqu'une page ne peut déclarer une même area qu'une fois) ; les éléments déjà
    // présents via un autre profil (même nom d'action) ne sont pas dupliqués.
    CaptionML = ENU = 'Super Admin Role Center', FRA = 'RC Super Admin';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            group("Groupe Caisse")
            {
                part("Caisse cue"; "Caisse cue")
                {
                    ApplicationArea = All;
                    Caption = 'Tickets';
                }
            }
            group("Comptable DA")
            {
                part(Control1000000024; "Purchase DA Agent Activities")
                {
                    Visible = true;
                }
                systempart(Control1901377608; MyNotes)
                {
                }
            }
            //=== Repris de "Creation ticket" (profil Création ticket, page 50129) ===
            group("Agent pesé")
            {
                part(Comptant; Comptant)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            //=== Repris de "Bookkeepe_DA Role Center" (profil Comptable DA) ===
            action("Bulletin transporteur")
            {
                CaptionML = FRA = 'Bulletin transporteur', ENU = 'Payroll slip transporters';
                Image = "Report";
                RunObject = Report "BULLETIN DU TRANSP.TEST 001";
            }
            action("Bulletin Planteur")
            {
                Captionml = FRA = 'Bulletin Planteur', ENU = 'Payroll slip planters';
                Image = "Report";
                RunObject = Report "Bulletin du Plan";
            }
            action("Bultin transp mensuel compt pi")
            {
                Captionml = FRA = 'Bulletin Transporteur Mensuel/Comptant/PI', ENU = 'Bulletin Transporteur Mensuel Comptant PI';
                Image = "Report";
                RunObject = Report 50577;
            }
            action("Paie transporteur par période")
            {
                CaptionML = FRA = 'Paie transporteur par période', ENU = 'Transporters Payroll by period';
                Image = "Report";
                RunObject = Report "Paie Transporteur par periode";
            }
            action("Report Paie Planteur par periode")
            {
                Captionml = FRA = 'Liste Paie Planteur par période', ENU = 'Planters Payroll by period';
                Image = "Report";
                RunObject = Report "Paie Planteur par periode GEN";
            }
            action("Paie Planteur par type d'opération")
            {
                CaptionML = FRA = 'Paie Planteur par type d''opération', ENU = 'Planters Payroll by operation';
                RunObject = Report "Paie Planteur periode par type";
            }
            action("Paie planteur par période: Mensuel")
            {
                CaptionML = FRA = 'Paie planteur par période: Mensuel', ENU = 'Planters Payroll by period:Monthly';
                Image = "Report";
                RunObject = Report "Paie Planteur periode MENS V3";
            }
            action("Balance fournisseurs")
            {
                CaptionML = FRA = 'Balance fournisseurs DEKEL', ENU = 'Listing Planters paid by period';
                Image = "Report";
                RunObject = Report 50444;
            }
            action("Paie planteur par période: Comptant")
            {
                Captionml = FRA = 'Paie planteur par période: Comptant', ENU = 'Planters Payroll by period:Cash';
                Image = "Report";
                RunObject = Report "Paie Planteur periode COMP";
            }
            action("Paie planteur par période: Direct")
            {
                Captionml = FRA = 'Paie planteur par période: Direct', ENU = 'Planters Payroll by period:Direct';
                Image = "Report";
                RunObject = Report "Paie Planteur periode DIREC";
            }
            action("Virements planteurs")
            {
                CaptionML = FRA = 'Virements planteurs', ENU = 'Planters Bank TRANSFER';
                Image = "Report";
                RunObject = Report "Etat VIREMENT PLANTEUR1";
            }
            action("Virements transporteurs")
            {
                Captionml = FRA = 'Virements transporteurs', ENU = 'Transporters Bank TRANSFER';
                Image = "Report";
                RunObject = Report "Etat VIREMENT TRANSPORTEUR";
            }
            action("PAIE TRANSP. PERIODE MENSUEL COMPTANT PI")
            {
                Captionml = FRA = 'Paie Transporteur Période Mensuel Comptant PI', ENU = 'Carrier Pay Monthly Cash PI';
                Image = "Report";
                RunObject = Report 50165;
            }
            action("PAIE TRANSPORTEUR PERIODE COMPTANT")
            {
                Captionml = FRA = 'Paie Transporteur Période Comptant', ENU = 'Pay Transporter Cash Period';
                Image = "Report";
                RunObject = Report 50166;
            }
            action("PAIE TRANSPORTEUR PERIODE DIRECT")
            {
                Captionml = FRA = 'Paie Transporteur Période Direct', ENU = 'Direct Period Carrier Pay';
                Image = "Report";
                RunObject = Report 50168;
            }
            action("PAIE TRANSPORTEUR PERIODE PI")
            {
                Captionml = FRA = 'Paie Transporteur Période PI', ENU = 'Carrier Payroll PI Period';
                Image = "Report";
                RunObject = Report 50164;
            }
            action("ETAT DETAILLE DES LIVRAISONS PLANTEURS")
            {
                Captionml = FRA = 'Etat Détaillé des livraison planteurs', ENU = 'Detailled Statement of DeliveriesS to Growers';
                Image = "Report";
                RunObject = Report 50106;
            }
            action("JOURNAL COMPTE FOURNISSEUR")
            {
                Captionml = FRA = 'Journal Compte Fournisseur', ENU = 'Vendor Journal';
                Image = "Report";
                RunObject = Report 10814;
            }
            action("RECHERCHE PLANTEURS REGULIERS")
            {
                Captionml = FRA = 'Recherche Planteurs Réguliers', ENU = 'Looking for Regular Planters';
                Image = "Report";
                RunObject = Report 50133;
            }
            group("&Trial Balance")
            {
                CaptionML = ENU = '&Trial Balance', FRA = 'Comptabilités générales';
                Image = Balance;

                action("&G/L Trial Balance")
                {
                    Captionml = ENU = '&G/L Trial Balance', FRA = 'Balance des comptes généraux';
                    Image = "Report";
                    RunObject = Report 50437;
                }
                action("Balance comptes fournisseurs")
                {
                    CaptionML = FRA = 'Balance comptes fournisseurs', ENU = 'Vendor Trial Balance';
                    Image = "Report";
                    RunObject = Report "Vendor Trial Balance Totaux";
                }
                action("G/L Detail Trial Balance")
                {
                    Captionml = ENU = 'G/L Detail Trial Balance', FRA = 'Grand livre comptes généraux';
                    Image = "Report";
                    RunObject = Report 50353;
                }
                action("Grand livre comptes fournisseurs")
                {
                    Captionml = FRA = 'Grand livre comptes fournisseurs', ENU = 'Vendor - Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report 50537;
                }
                action("Trial balance by period")
                {
                    Captionml = FRA = 'Balance par période', ENU = 'Trial balance by period';
                    Image = "Report";
                    RunObject = Report 50537;
                }
            }
            separator(Separator1120007)
            {
            }
            group(Planteurs)
            {
                CaptionML = FRA = 'Planteurs', ENU = 'Planters';
                action("Virements par coopératives")
                {
                    Captionml = FRA = 'Virements par coopératives', ENU = 'Bank transfer by cooperatives ';
                    Image = "Report";
                    RunObject = Report "Virement plant. par cooperativ";
                }
                action("Virements usagers")
                {
                    Captionml = FRA = 'Virements usagers', ENU = 'User deposits';
                    Image = "Report";
                    RunObject = Report "Virement plant. usager";
                }
                action("Règlements par coopératives")
                {
                    CaptionML = FRA = 'Règlements par coopératives', ENU = '';
                    Image = "Report";
                    RunObject = Report "Reglment plant. par cooperativ";
                }
                action("Règlements usagers")
                {
                    Captionml = FRA = 'Règlements usagers', ENU = 'User regulations';
                    Image = "Report";
                    RunObject = Report "Reglment plant. usager";
                }
            }
            group(Transporteurs)
            {
                CaptionML = FRA = 'Transporteurs', ENU = 'Transporters';
                action(Action1000000028)
                {
                    Captionml = FRA = 'Virements par coopératives', ENU = 'Bank transfer by cooperatives';
                    Image = "Report";
                    RunObject = Report "Virement trans. par cooperativ";
                }
                action("Virements par centres logistiques")
                {
                    Captionml = FRA = 'Virements par centres logistiques', ENU = ' Bank transfer by Logistics Centrer';
                    Image = "Report";
                    RunObject = Report "Virement trans. par CL";
                }
                action(Action1000000026)
                {
                    CaptionML = FRA = 'Règlements par coopératives', ENU = 'Cooperatives Regulations';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par cooperativ";
                }
                action("Règlements par centres logistiques")
                {
                    CaptionML = FRA = 'Règlements par centres logistiques', ENU = 'Logistics Centrer Regulations';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par CL";
                }
            }
            group("Etats Achat regime")
            {
                CaptionML = FRA = 'Etats Achat régime';
                action("Bulletin du planteur")
                {
                    CaptionML = FRA = 'Bulletin du planteur', ENU = '';
                    Image = "Report";
                    RunObject = Report 50145;
                }
                action("Achats articles par fourn.")
                {
                    CaptionML = FRA = 'Règlements par centres logistiques', ENU = '';
                    Image = "Report";
                    RunObject = Report 313;
                }
                action("Commande achat en cours")
                {
                    CaptionML = FRA = 'Commande achat en cours', ENU = '';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par CL";
                }
                action("Articles catalogue fourn.")
                {
                    CaptionML = FRA = 'Articles : catalogue fourn.', ENU = '';
                    Image = "Report";
                    RunObject = Report 720;
                }
                action("Livraison planteurs par coop.")
                {
                    CaptionML = FRA = 'Livraison planteurs par coop.', ENU = '';
                    Image = "Report";
                    RunObject = Report 50124;
                }
                action("Etat detaille livraisons planteurs")
                {
                    CaptionML = FRA = 'Etat detaillé livraisons planteurs', ENU = '';
                    Image = "Report";
                    RunObject = Report 50106;
                }
                action("Bulletin Bonus planteur")
                {
                    CaptionML = FRA = 'Bulletin Bonus Planteurs', ENU = '';
                    Image = "Report";
                    RunObject = Report 50406;
                }
                action("Recap livraisons regimes")
                {
                    CaptionML = FRA = 'Recap livraisons régimes', ENU = 'Recap diet deliveries';
                    Image = "Report";
                    RunObject = Report 50082;
                }
            }
            group("Etats Achat transport")
            {
                CaptionML = FRA = 'Etats Achat transport';
                action("Bulletin du transporteur")
                {
                    CaptionML = FRA = 'Bulletin transporteur', ENU = '';
                    Image = "Report";
                    RunObject = Report 50093;
                }
                action("Bulletin transport TEST")
                {
                    CaptionML = FRA = 'Bulletin transport TEST', ENU = '';
                    Image = "Report";
                    RunObject = Report 50147;
                }
                action("Achat article par fourn")
                {
                    CaptionML = FRA = 'Achats d''articles par fourn', ENU = '';
                    Image = "Report";
                    RunObject = Report 313;
                }
                action("Commandes achats en cours")
                {
                    CaptionML = FRA = 'Articles : catalogue fourn.', ENU = '';
                    Image = "Report";
                    RunObject = Report 709;
                }
                action("articles categories fournisseurs")
                {
                    CaptionML = FRA = 'Livraison planteurs par coop.', ENU = '';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par CL";
                }
            }
            group("Gestion des prêts engrais")
            {
                Visible = true;
                CaptionML = FRA = 'Gestion des prêts engrais', ENU = '';
                action("Recap pret  engrais")
                {
                    CaptionML = FRA = 'Recap prêts engrais', ENU = '';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par CL";
                }
                action("Recap livraisons engrais")
                {
                    CaptionML = FRA = 'Recap livraisons engrais', ENU = '';
                    Image = "Report";
                    RunObject = Report "Reglment trans. par CL";
                }
            }
        }
        area(Creation)
        {
            //=== Repris de "Caisse RoleCenter" (profil Caisse) ===
            action("Dépots")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70014;
                RunPageMode = Create;
                Visible = false;
            }
            action("Mouvements Entrées et sorties")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70020;
                RunPageMode = Create;
                Visible = false;
            }
            //=== Repris de "Bookkeepe_DA Role Center" (profil Comptable DA) ===
            action("&Vendor")
            {
                CaptionML = ENU = '&Vendor', FRA = 'Fournisseur';
                Image = Vendor;
                RunObject = Page "Vendor Card";
                RunPageMode = Create;
            }
            action("Factures achats.")
            {
                CaptionML = ENU = 'Purchase Invoices', FRA = 'Factures achats';
                Image = Invoice;
                RunObject = page "factures achats";
            }
            action(Action1000000003)
            {
                CaptionML = FRA = 'Factures transporteurs', ENU = 'Carrier invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices transporteur";
            }
            action("Facture regime")
            {
                CaptionML = FRA = 'Factures régimes', ENU = 'Plan invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices planteur";
            }
            action(Action1000000011)
            {
                CaptionML = FRA = 'Avoirs régimes', ENU = 'Credit memo assets';
                Image = CreditMemo;
                RunObject = Page "Purchase Credit Memos";
                RunPageMode = Create;
            }
            action("Avoires transporteurs")
            {
                CaptionML = FRA = 'Avoirs transporteurs', ENU = 'Carrier credit memo';
                Image = CreditMemo;
                RunObject = Page "Purchase Credit Memos transpor";
                RunPageMode = Create;
            }
        }
        area(Sections)
        {
            //=== Repris de "Caisse RoleCenter" (profil Caisse) ===
            group(Historiques)
            {
                action(HistoriquesPlanteur)
                {
                    Promoted = True;
                    ApplicationArea = All;
                    PromotedCategory = Category12;
                    Caption = 'Archives paiement régime';
                    RunObject = page ListePantPlanteurArchive;
                }
                action(HistoriquesTransporteur)
                {
                    Promoted = True;
                    ApplicationArea = All;
                    PromotedCategory = Category12;
                    Caption = 'Archives paiement transport';
                    RunObject = page ListePantTransporteurArchive;
                }
            }
            //=== Repris de "Bookkeepe_DA Role Center" (profil Comptable DA) ===
            group("Gestion des tickets")
            {
                Caption = 'Gestion des tickets';
                action("Tickets pont bascule Récap")
                {
                    CaptionML = ENU = 'Item Weight Bridge', FRA = 'Tickets pont bascule Récap';
                    RunObject = page "Item Weight Bridge";
                }
                action("Tickets pont bascule Adiake")
                {
                    CaptionML = ENU = 'Item Weight Bridge Adiake', FRA = 'Tickets pont bascule Adiaké';
                    RunObject = page "Item Weight BridgeAD";
                }
                action("Tickets pont bascule Allakro")
                {
                    CaptionML = ENU = 'Item Weight Bridge Allakro', FRA = 'Tickets pont bascule Allakro';
                    RunObject = page "Item Weight BridgeAL";
                }
                action("Tickets pont bascule Assue")
                {
                    CaptionML = ENU = 'Item Weight Bridge Assue', FRA = 'Tickets pont bascule Assue';
                    RunObject = page 50099;
                }
                action("Tickets pont bascule Ayenouan")
                {
                    CaptionML = ENU = 'Item Weight Bridge Ayenouan', FRA = 'Tickets pont bascule Ayenouan';
                    RunObject = page 50091;
                }
                action("Tickets pont bascule Bafia")
                {
                    CaptionML = ENU = 'Item Weight Bridge Bafia', FRA = 'Tickets pont bascule Bafia';
                    RunObject = page 50105;
                }
                action("Tickets pont bascule Eboue")
                {
                    CaptionML = ENU = 'Item Weight Bridge Eboue', FRA = 'Tickets pont bascule Eboue';
                    RunObject = page 50095;
                }
                action("Tickets pont bascule Etueboue")
                {
                    CaptionML = ENU = 'Item Weight Bridge Etueboue', FRA = 'Tickets pont bascule Etueboue';
                    RunObject = page 50097;
                }
                action("Tickets pont bascule Jerusalem")
                {
                    CaptionML = ENU = 'Item Weight Bridge Jerusalem', FRA = 'Tickets pont bascule Jerusalem';
                    RunObject = page 50104;
                }
                action("Tickets pont bascule Malamalakro")
                {
                    CaptionML = ENU = 'Item Weight Bridge Malamalakro', FRA = 'Tickets pont bascule Malamalakro';
                    RunObject = page 50111;
                }
                action("Tickets pont bascule Kotouagnuan")
                {
                    CaptionML = ENU = 'Item Weight Bridge Kotouagnuan', FRA = 'Tickets pont bascule Kotouagnuan';
                    RunObject = page 50117;
                }
                //=== Repris de "IT DEKEL Role Center" (profil IT DEKEL, page 50130) ===
                action("Tickets pont bascule Vente")
                {
                    CaptionML = ENU = 'Item Weight Bridge Vente', FRA = 'Tickets pont bascule Vente';
                    RunObject = page 50300;
                }
            }
            group("Gestion paiement tickets")
            {
                caption = 'Gestion paiement tickets';
                action("Tickets pont bascule Paiement")
                {
                    CaptionML = ENU = 'Item Weight Bridge Payment', FRA = 'Paiement ticket pont bascule';
                    RunObject = page "recap tiket achat";
                }
                action("Recapitulatif paiement")
                {
                    CaptionML = ENU = 'Payment recap', FRA = 'Recap paiement';
                    RunObject = page "recap paiement";
                }
                action("Bordereaux paiement")
                {
                    CaptionML = ENU = 'Payment Slip', FRA = 'Bordereaux paiement';
                    RunObject = page "Payment Slip List";
                }
            }
            group("Archives")
            {
                Caption = 'Documents validés';
                Image = FiledPosted;
                action("Factures planteur enregistrées")
                {
                    Captionml = FRA = 'Factures planteur enregistrées', ENU = 'Posted Purchase Invoices Planters';
                    RunObject = Page "Posted Purchase Invoices DEKEL";
                }
                action("Factures transporteur enregistrées")
                {
                    Captionml = FRA = 'Factures transporteur enregistrées', ENU = 'Posted Purchase Invoices Transporters';
                    RunObject = Page "Posted Purchase Invoices FTR";
                }
                action("Tickets traités")
                {
                    Captionml = FRA = 'Tickets traités', ENU = 'Tickets Treated ';
                    RunObject = Page "Hist.Item Weight Bridge";
                }
                action("Posted Purchase Receipts")
                {
                    CaptionMl = ENU = 'Posted Purchase Receipts', FRA = 'Réceptions achats enregistrées';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    CaptionML = ENU = 'Posted Purchase Invoices', FRA = 'Factures achats enregistrées';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Avoirs achat enregistrés transporteurs")
                {
                    CaptionML = FRA = 'Avoirs achat enregistrés transporteurs', ENU = 'Carrier recorded purchase credits memos';
                    RunObject = Page "Posted Purchase Credit Memo Tr";
                }
                action("Avoir achat enregistrés planteurs")
                {
                    CaptionML = ENU = 'Posted Purchase Credit Memos', FRA = 'Avoir achat enregistrés planteurs';
                    RunObject = Page "Posted Purchase Credit Mem";
                }
                action("G/L Registers")
                {
                    Captionml = ENU = 'G/L Registers', FRA = 'Historique des transactions comptabilisées';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Payment Slip List Archives")
                {
                    CaptionML = ENU = 'Payment Slip List Archives', FRA = 'Bordereaux paiement archivés';
                    RunObject = Page "Payment Slip List Archive";
                }
            }
            //=== Repris de "IT DEKEL Role Center" (profil IT DEKEL, page 50130) ===
            group("Gestion PI")
            {
                CaptionML = FRA = 'Gestion PI', ENU = '';
                action(Parcelles)
                {
                    CaptionML = FRA = 'Parcelles', ENU = 'Parcels';
                    RunObject = Page Parcelles;
                }
                action("Propriétaires")
                {
                    CaptionML = FRA = 'Propriétaires', ENU = 'Owners';
                    RunObject = Page "Propriétaires";
                }
                action("Prêts parcelles")
                {
                    Captionml = FRA = 'Prêts parcelles', ENU = 'Parcels Loan';
                    RunObject = Page "Pret parcelle List";
                }
                action("Pi suspendu")
                {
                    CaptionML = FRA = 'Liste fournisseurs PI suspendu', ENU = 'Vendors PI suspended';
                    RunObject = Page "PI Supensdu List";
                }
                action("Traitement des tickets PI")
                {
                    CaptionML = FRA = 'Traitement PI', ENU = 'PI treatment';
                    RunObject = page "Item Weight Bridge PI";
                }
                action("Saisie des entretiens PI")
                {
                    Captionml = FRA = 'Saisie des entretiens PI', ENU = 'Pi Maintenance';
                    RunObject = page "Entretien List";
                }
                action("Pret engrais PI")
                {
                    CaptionML = FRA = 'Pret engrais PI', ENU = 'Pi fertilizer Loan';
                    RunObject = page "Prets engrais PI List";
                }
                action("Programme Plant PI")
                {
                    CaptionML = ENU = 'PI plant Program', FRA = 'Programme Plant PI';
                    RunObject = page "Programme Plant PI List";
                }
                action("Ecrit Compta Parcelle PI")
                {
                    CaptionML = ENU = 'PI Parcel Entries', FRA = 'Ecriture parcelle PI';
                    RunObject = page 50604;
                }
            }
        }
        area(Embedding)
        {
            //=== Repris de "Caisse RoleCenter" (profil Caisse) ===
            action("Ouverture de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70022;
            }
            action("Clôture de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70027;
            }
            action(Paiement_Multiple)
            {
                Caption = 'Paiement Régime';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = Page 70116;
            }
            action(Paiement_Multiple_Transp)
            {
                Caption = 'Paiement Transport';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = Page ListePaiementTransporteur;
            }
            action(ImpressionPaimentPlanter)
            {
                Caption = 'Impression en masse planteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = report 70048;
                Visible = false;
            }
            action(ImpressionTansporrteur)
            {
                Caption = 'Impression en masse Transporteur';
                Promoted = true;
                PromotedCategory = Process;
                RunPageMode = Create;
                ApplicationArea = All;
                RunObject = report 70048;
                Visible = false;
            }
            action("Recap transporteur")
            {
                Caption = 'Etat Recap transporteur';
                RunObject = report 70055;
                ApplicationArea = All;
            }
            action("Recap planteur")
            {
                Caption = 'Etat Recap planteur';
                RunObject = report 70056;
                ApplicationArea = All;
            }
            action("Historique")
            {
                Caption = 'Les tickets validés';
                RunObject = Page TicketsPayes;
                ApplicationArea = All;
            }
            action("Caisse")
            {
                Caption = 'Point de caisse';
                RunObject = Page PointCaisses;
                ApplicationArea = All;
            }
            action("Liste des encaissements")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70033;
                Visible = false;
            }
            action("Liste des dépots")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70013;
                Visible = false;
            }
            action("Liste des mouvements de caisse")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70021;
                Visible = false;
            }
            action("Liste des transactions")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page 70012;
            }
            action("Compte tiers d")
            {
                Caption = 'INFOS CLIENTS ';
                Image = Customer;
                RunObject = page "Compte tiers activity Caisse";
                Visible = false;
            }
            //=== Repris de "Bookkeepe_DA Role Center" (profil Comptable DA) ===
            action(Items)
            {
                CaptionML = ENU = 'Items', FRA = 'Articles';
                Image = Item;
                RunObject = Page "Item List";
            }
            action("Chart of Accounts")
            {
                Captionml = ENU = 'Chart of Accounts', FRA = 'Plan comptable';
                RunObject = Page "Chart of Accounts";
            }
            action(Action1000000000)
            {
                CaptionML = FRA = 'Planteurs', ENU = 'Planters';
                RunObject = Page "Vendor List planteurs";
            }
            action(Action1000000001)
            {
                CaptionML = FRA = 'Transporteurs', ENU = 'Transporters';
                RunObject = Page "Vendor List Transp";
            }
            action("Factures Achats")
            {
                CaptionML = ENU = 'Purchase Invoices', FRA = 'Factures Achats';
                RunObject = page "Factures achats";
            }
            action("Factures transporteurs")
            {
                Captionml = FRA = 'Factures transporteurs', ENU = 'Purchase Invoices transporters';
                RunObject = Page "Purchase Invoices transporteur";
            }
            action("Avoirs régimes")
            {
                Captionml = FRA = 'Avoirs régimes', ENU = 'Purchase Credit Memos planters';
                RunObject = Page "Purchase Credit Memos";
            }
            action("Avoirs transporteurs")
            {
                CaptionML = FRA = 'Avoirs transporteurs', ENU = 'Purchase Credit Memos transporters';
                RunObject = Page "Purchase Credit Memos transpor";
            }
            action("Paramètres BD PIC")
            {
                CaptionML = FRA = 'Paramètres BD PIC', ENU = 'PIC Database Setting';
                RunObject = page "Weight Bridge Setup1";
                Visible = false;
            }
            action("Para prime")
            {
                Caption = 'Paramètres primes';
                RunObject = page "Planter Purchase Prices";
            }
            action("MagasinCentreLogistique")
            {
                CaptionML = ENU = 'Warehouse Logistics Center', FRA = 'Magasin Centre Logistique';
                RunObject = page listeMagasinCentreLogistique;
                Visible = false;
            }
            action("Parametres Retenues")
            {
                CaptionML = ENU = 'Deduction parameters', FRA = 'Parametres Retenues';
                runobject = page "Vendor Split Vat Setup";
            }
            action("Prets engrais List")
            {
                CaptionML = ENU = '', FRA = 'Liste Prêts engrais';
                runobject = page 50509;
                Visible = false;
            }
            action("Prog plant List")
            {
                CaptionML = ENU = '', FRA = 'Liste Programme plants';
                runobject = page 50519;
                Visible = false;
            }
            action("Sorties magasin")
            {
                Captionml = FRA = 'Sorties magasin', ENU = 'Material Transfer List';
                RunObject = Page "Material Transfer List";
            }
            action("Detail reglement")
            {
                Captionml = FRA = 'Détails règlement', ENU = 'Payment details';
                RunObject = Page 50005;
            }
            action("Ecrit compt. Fourn Detail")
            {
                CaptionML = ENU = 'Detailed Vendor Ledg. Entries', FRA = 'Écritures Comptables Fournisseur Détaillées';
                RunObject = Page "Detailed Vendor Ledg. Entries";
            }
            action("Ecriture valeur")
            {
                CaptionML = ENU = 'Value entries', FRA = 'Ecritures valeur';
                RunObject = Page 5802;
            }
            action("CONTRÔLE TICKET PONT BASCULE")
            {
                CaptionML = ENU = 'Check Item Weight Bridge', FRA = 'Controle  Ticket Pont Bascule';
                RunObject = Page 50227;
            }
            action("Banques")
            {
                CaptionML = ENU = 'Bank Account', FRA = 'Comptes Bancaires';
                RunObject = Page "Bank Account List";
            }
            action("cooperatives")
            {
                CaptionML = ENU = 'Cooperatives', FRA = 'Coopératives';
                RunObject = Page 50013;
            }
            //=== Repris de "IT DEKEL Role Center" (profil IT DEKEL, page 50130) ===
            action(Ticket)
            {
                Caption = 'Tickets validés';
                ApplicationArea = All;
                RunObject = page Creation_Tickets;
            }
            //=== Repris de "Creation ticket" (profil Création ticket, page 50129) ===
            action("EmbeddingAction")
            {
                Caption = 'Ticket pont bascule';
                RunObject = Page 50208;
                ApplicationArea = All;
                Visible = false;
            }
            action("EmbeddingActionS")
            {
                Caption = 'Ticket pont bascule multi-pesé';
                RunObject = Page MultiPeseSubForm;
                ApplicationArea = All;
                Visible = false;
            }
        }
        area(processing)
        {
            //=== Repris de "Bookkeepe_DA Role Center" (profil Comptable DA) ===
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Mise à jour Tickets")
            {
                Caption = 'Mise à jour Tickets';
                Image = UpdateShipment;
                RunObject = codeunit "ERP Interfacing";
                ApplicationArea = all;
                Visible = false;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                CaptionML = ENU = 'Navi&gate', FRA = 'Naviguer';
                Image = Navigate;
                RunObject = Page Navigate;
            }
        }
    }
}
