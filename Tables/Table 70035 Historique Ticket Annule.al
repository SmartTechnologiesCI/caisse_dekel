table 70035 "Item Weigh Bridge Cancel"
{
    // PROJECT :
    // ****************************************************************************************************************************************************************
    // SIGN
    // ****************************************************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // ****************************************************************************************************************************************************************
    // VER      SIGN     DATE        UserID             DESCRIPTION
    // ****************************************************************************************************************************************************************
    // 1.47     B2B    20-Apr-15    SatishKNV           New table is created for Item Weight Bridge Functionality related.

    Captionml = FRA = 'Ticket pont bascule', ENU = 'Item Weight Bridge';
    DrillDownPageID = "Item Weight Bridge";
    LookupPageID = "Item Weight Bridge";
    
    fields
    {
        field(1; TICKET; Integer)
        {
            CaptionML = FRA = 'N° Ticket', ENU = 'Ticket no.';
            // AutoIncrement=true;//FnGeek 05_09_25
        }

        field(2541; "Selection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Vehicle Registration No."; Code[50])
        {
            CaptionML = ENU = 'Vehicle Registration No.:', FRA = 'N° immatriculation  véhicule';
        }
        field(7; "Driver Name"; Code[250])
        {
            CaptionML = ENU = 'Driver Name:', FRA = 'Nom conducteur';

        }
        field(8; "Item Origin"; Code[250])
        {
            CaptionML = ENU = 'Item Origin:', FRA = 'Origine article';
            Editable = true;
        }
        field(9; BonEnlevement; Text[250])
        {
            CaptionML = FRA = 'Bon d''enlèvement', ENU = 'Collection order';
        }
        field(25; "POIDS ENTREE"; Decimal)
        {
            CaptionML = FRA = 'Poids entrée', ENU = 'Entry weight';
            // Editable = false;
        }
        field(56; "POIDS SORTIE"; Decimal)
        {
            CaptionML = FRA = 'Poids sortie', ENU = 'Weight out';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // if rec.MultiPese = true then begin
                //     if "POIDS SORTIE" <> 0 then begin
                //         if "POIDS NET" = 0 then begin
                //             REC."POIDS NET" := rec."POIDS ENTREE" - Rec."POIDS SORTIE";
                //             REC.Modify();
                //         end;

                //     end;
                // end;
            end;
            // Editable = false;
        }
        field(78; "POIDS NET"; Decimal)
        {
            CaptionML = FRA = 'Poids net', ENU = 'Net weight';
            // Editable = true;
        }
        field(79; "Row No."; Integer)
        {
            CaptionML = FRA = 'N° sequence', ENU = 'Entry no.';
        }
        field(80; "Type opération"; Text[50])
        {
            CaptionML = FRA = 'Type opération', ENU = 'Operation type';
        }
        field(81; Transporteur; Text[80])
        {
            CaptionML = FRA = 'Transporteur', ENU = 'Transporter';
        }
        field(500; Uploaded; Boolean)
        {
            CaptionML = FRA = 'Traité', ENU = 'Uploaded';
        }
        field(800; "Weighing 1 Date"; Date)
        {
            CaptionML = FRA = 'Date entrée', ENU = 'Entry date';
        }
        field(805; "Weighing 2 Date"; Date)
        {
            CaptionML = FRA = 'Date sortie', ENU = 'Weighing 2 Date';
        }
        field(900; "Weighing 1 Hour"; Time)
        {
            CaptionML = FRA = 'Heure entrée', ENU = 'Weighing 1 Hour';
        }
        field(905; "Weighing 2 Hour"; Time)
        {
            Captionml = FRA = 'Heure sortie', ENU = 'Weighing 2 Hour';
        }
        field(908; "Type of Transportation"; Code[50])
        {
            CaptionML = FRA = 'Mouvement', ENU = 'Movement';
        }
        field(920; "Purchase Order Created"; Boolean)
        {
            CaptionML = FRA = 'Commande achat créee', ENU = 'Purchase Order Created';
        }
        field(921; "Code planteur"; Code[50])
        {
            CaptionML = ENU = 'Planter code', FRA = 'Code planteur';
            Description = 'JJ SMART';

        }
        field(922; "Nom planteur"; Text[250])
        {
            CaptionML = ENU = 'Planter name', FRA = 'Nom planteur';
            Description = 'JJ SMART';
        }
        field(923; "Ticket Planteur"; Text[50])
        {
            CaptionML = ENU = 'Planteur Ticket', FRA = 'Ticket Planteur';
            Description = 'JJ SMART';

            trigger OnValidate()
            var
                // NoSeries: Codeunit "No. Series";
                NoSeries: Record "No. Series";
                Balance: Record Balance;
            begin
                // if "No." <> xRec."No." then begin
                //     GetInventorySetup();
                //     NoSeries.TestManual(GetNoSeriesCode());
                //     "No. Series" := '';
                // end;
                rec.TestField("Balance Code");

                if "Ticket Planteur" <> xRec."Ticket Planteur" then begin
                    /**FnGeek à conserver
                    "Param Caisse".Get();
                    NoSeriesMgt.TestManual("Param Caisse"."N° souhe Appro");
                    "No. Series" := '';
                    ***/
                    Balance.SetRange(Code, rec."Balance Code");
                    if Balance.FindFirst() then begin

                        // NoSeriesMgt.GetLastNoUsed(Balance."Souche N°");
                        "Ticket Planteur" := NoSeriesMgt.GetNextNo(Balance."Souche N°", WorkDate(), true);
                    end;
                    /*if xRec."No Point" = '' then
                        "Costing Method" := InvtSetup."Default Costing Method";*/
                    // HRSetup.TESTFIELD(DmdeStageEmbauche);

                end;
            end;

        }
        field(924; "Code article"; Code[10])
        {
            CaptionML = ENU = 'Item code', FRA = 'Code article';
            Description = 'JJ SMART';
        }
        field(925; "Désignation article"; Text[50])
        {
            CaptionML = ENU = 'Item designation', FRA = 'Désignation article';
            Description = 'JJ SMART';
        }
        field(926; "Code Transporteur"; Code[25])
        {
            CaptionML = ENU = 'Transporter code', FRA = 'Code Transporteur';
            Description = 'JJ SMART';
            trigger OnValidate()
            var
                myInt: Integer;
                Vend: Record Vendor;
                Custom: Record Customer;
            begin

                Vend.SetRange("No.", rec."Code Transporteur");
                if Vend.FindFirst() then begin
                    rec."Nom Transporteur" := Vend.Name;
                end

            end;

            /*TableRelation = if (Type = const(" ")) "Standard Text"
           else
           if (Type = const("G/L Account"), "System-Created Entry" = const(false)) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
           else
           if (Type = const("G/L Account"), "System-Created Entry" = const(true)) "G/L Account"
           else
           if (Type = const(Resource)) Resource
           else*/

        }
        field(927; "Nom Transporteur"; Text[50])
        {
            CaptionML = ENU = 'Transporter name', FRA = 'Nom Transporteur';
        }
        field(1500; "Purchase invoice Created"; Boolean)
        {
            CaptionML = ENU = 'Purchase invoice Created', FRA = 'Facture Régime créée';
            Editable = true;
        }
        field(2500; "Purchase Invoice No."; Code[50])
        {
            // CaptionML = ENU = 'Purchase Invoice No.', FRA = 'N° facture achat';
            CaptionML = ENU = 'Purchase Invoice No.', FRA = 'N° Facture Régime';
            Editable = true;
        }
        field(2501; "Purchase invoice Tcreate"; Boolean)
        {
            // CaptionML = ENU = 'Purchase invoice Created', FRA = 'Facture achat créée';
            CaptionML = ENU = 'Purchase invoice Created', FRA = 'Facture Transport créée';
            Editable = true;
        }
        field(2502; "TPurchase Invoice No."; Code[50])
        {
            CaptionML = ENU = 'TPurchase Invoice No.', FRA = 'N° Facture transport';
        }
        field(2503; RowID; Integer)
        {
            CaptionML = ENU = 'RowID', FRA = 'IDLine';
            AutoIncrement = true;
        }
        field(2504; "Code Client"; Code[30])
        {
            CaptionML = ENU = 'Customer code', FRA = 'Code Client';
            trigger OnValidate()
            var
                myInt: Integer;
                Vend: Record Vendor;
                Custom: Record Customer;
            begin

                Custom.SetRange("No.", rec."Code Client");
                if Custom.FindFirst() then begin
                    rec."Nom Client" := Custom.Name;
                end;

            end;

        }
        field(2505; "Nom Client"; Text[50])
        {
            CaptionML = ENU = 'Customer Name', FRA = 'Nom Client';
        }
        field(2506; "Sales invoice Created"; Boolean)
        {
            CaptionML = ENU = 'Sales invoice Created', FRA = 'Facture vente créée';
            Editable = true;
        }
        field(2507; "Sales Invoice No."; Code[50])
        {
            CaptionML = ENU = 'Sales Invoice No.', FRA = 'N° facture vente';
            Editable = true;
        }
        field(2508; "Code magasin"; Code[50])
        {
            CaptionML = ENU = 'Location code', FRA = 'Code magasin';
            TableRelation = Location;
        }
        field(2509; "N° Commande PIC"; Code[50])
        {
            CaptionML = ENU = 'PIC order no.', FRA = 'N° Commande PIC';
            TableRelation = "Sales Header" WHERE("Document Type" = CONST(Order),
                                                  "Sell-to Customer No." = FIELD("Code Client"));
        }
        field(2510; EtatTransport; Code[2])
        {
            CaptionML = ENU = 'State transport', FRA = 'Etat Transport';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2511; EtatRegime; Code[2])
        {
            CaptionML = ENU = 'State regime', FRA = 'EtatRegime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2512; ValeurAIPH; Decimal)
        {
            CaptionML = ENU = 'AIPH value', FRA = 'Valeur AIPH';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2513; TotalRegime; Decimal)
        {
            CaptionML = ENU = 'Total regime', FRA = 'Régime total';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2514; TauxOPAR; Decimal)
        {
            CaptionML = ENU = 'OPAR rate', FRA = 'Taux OPAR';

            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2515; TotalOPAR; Decimal)
        {
            CaptionML = ENU = 'OPAR Total', FRA = 'Total OPAR';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2516; TauxImpotRegime; Decimal)
        {
            CaptionML = ENU = 'Tax Rate Regime', FRA = 'Taux Impot Régime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2517; ValeurImpotRegime; Decimal)
        {
            CaptionML = ENU = 'Tax value regime', FRA = 'Valeur impot régime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2518; MontantNetRegime; Decimal)
        {
            CaptionML = ENU = 'Regime Net Amount', FRA = 'Montant Net Régime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2519; ValeurTransport; Decimal)
        {
            CaptionML = ENU = 'Transport Value', FRA = 'Valeur Transport';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2520; TotalTransport; Decimal)
        {
            CaptionML = ENU = 'total transport', FRA = 'Transport total';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2521; TauxOPAT; Decimal)
        {
            CaptionML = ENU = 'OPAT rate', FRA = 'Taux OPAT';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2522; TotalOPAT; Decimal)
        {
            CaptionML = ENU = 'OPAT Total', FRA = 'Total OPAT';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2523; TauxImpotTransp; Decimal)
        {
            CaptionML = ENU = 'Tax rate transp.', FRA = 'Taux Impot Transp.';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2524; ValeurImpoTransp; Decimal)
        {
            CaptionML = ENU = 'Tax value transp.', FRA = 'Valeur Impot Transp.';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2525; MontantNetTransp; Decimal)
        {
            CaptionML = ENU = 'transp. net  Amount', FRA = 'Montant Net Transp';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2526; DateRegime; Date)
        {
            CaptionML = ENU = 'Regime payment date', FRA = 'Date paiement regime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2527; DateTransport; Date)
        {
            CaptionML = ENU = 'Transport payment date', FRA = 'Date paiement transport';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2528; NumeroRegime; Integer)
        {
            CaptionML = ENU = 'Regime no.', FRA = 'Numero Régime';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2529; NumeroTransp; Integer)
        {
            CaptionML = ENU = 'Transp. no.', FRA = 'Numéro Transp.';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2530; "Ligne paiement"; Boolean)
        {
            CaptionML = ENU = 'Planter payment line', FRA = 'Ligne paiement Planteur';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2531; "Traitement effectué"; Boolean)
        {
            CaptionML = ENU = 'Treatment effected', FRA = 'Traitement effectué"';
        }
        field(2532; Commentaire; Text[50])
        {
            CaptionML = ENU = 'Planter comment', FRA = 'Commentaire Planteur';

        }
        field(2533; ValautoDateTime; DateTime)
        {
            CaptionML = ENU = 'Automatic execution', FRA = 'Exécution automatique';

        }
        field(2534; CommentaireT; Text[50])
        {
            CaptionML = ENU = 'Transport comment', FRA = 'Commentaire Transport';

        }
        field(2535; "Ligne paiement trans"; Boolean)
        {
            CaptionML = ENU = 'Transport payment line', FRA = 'Ligne paiement Transport';
            Description = 'Smart olivier / Traitement automatique des paiements ticket';
        }
        field(2536; Doublon; Boolean)
        {
            CaptionML = ENU = 'Double', FRA = 'Doublon';
        }
        field(2537; "Ticket annule"; Boolean)
        {
            CaptionML = ENU = 'Ticket cancelled', FRA = 'Ticket annulé';
            Description = 'Ticket annule';
        }

        field(2538; "Transporteur dekel"; Boolean)
        {
            CaptionML = ENU = 'Transporter dekel', FRA = 'Transporteur dekel';
            Description = 'Transporteur dekel';
        }

        field(2539; "Planteur paye"; Boolean)
        {
            CaptionML = ENU = 'Planter paid', FRA = 'Planteur paye';
            Description = 'Planteur paye';
        }

        field(2540; "Transporteur paye"; Boolean)
        {
            CaptionML = ENU = 'Transport paid', FRA = 'Transport payé';
            Description = 'Transporteur paye';
        }
        //<<Saber translate by Fab Smart 05_04_25
        field(2550; "Balance Code"; code[20])
        {
            CaptionML = ENU = 'Scale Code', FRA = 'Balance code';
            // TableRelation = balance.Code;
        }
        field(2551; "Process Ticket"; Option)
        {
            OptionMembers = Validated,Create,Update;
            // Editable = false;
        }
        //<<Saber translate by Fab Smart 05_04_25
        //<<Fabrice Smart 05_03_25
        field(2552; "Client/Fournisseur"; CODE[50])
        {
            Caption = 'Client/Fournisseur';
            TableRelation = Client_Fournisseur.code_clent_Fournisseur;
            trigger OnValidate()
            var
                myInt: Integer;
                clientfournisseur: Record Client_Fournisseur;
            begin
                clientfournisseur.SetRange(code_clent_Fournisseur, rec."Client/Fournisseur");
                if clientfournisseur.FindFirst() then begin
                    rec.Description_Client_Fournisseur := clientfournisseur.Libelle;
                    //***Numéro ticket
                end;
            end;
            // OptionCaption = " ",Client,"Plantation villageoise", "Centre Logistique";
        }
        field(2553; ORIGINE; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2554; ETATID; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20555; "Type Vehicule"; Code[50])
        {
            // OptionMembers = "Remorque","Tracteur";
        }
        //<<Fabrice Smart 05_03_25
        field(50000; valide; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Posted', FRA = 'Validé';
        }
        field(50001; "Date validation"; Date)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Posted Date', FRA = 'Date validation';
        }
        field(50002; "Statut paiement"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statut paiement Transporteur';
        }
        field(50003; "Statut paiement Planteur"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statut paiement Planteur';
        }
        //FnGeek 04_09_25
        field(50004; CodeIncrementAuto; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(50005; CodeIncrementAuto2; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        //FnGeek 04_09_25
        //FnGeek 05_09_25
        field(50006; "Nombre de planteurs"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; MultiPese; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Multipesé';
        }
        //FnGeek 
        field(50008; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Date_Paiement; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date paiement';
        }
        field(50011; Beneficiaire; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bénéficiare';
        }
        field(50012; NCNI; code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° pièce';
        }
        field(50013; Mode_Paiement; Option)
        {
            Caption = 'Mode Paiement';
            DataClassification = ToBeClassified;
            OptionMembers = ESPECE,WAVE,OM,"MTN Money","MOOV Money",CHEQUE,Push,Virement;
        }
        field(50014; Observation; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; Type_Operation_Options; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "ACHAT DIRECT","ACHAT COMPTANT";
        }
        field(50017; "Code Conducteur"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Conducteur."Code conducteur";
            trigger OnValidate()
            var
                Conducteur: Record Conducteur;
            begin
                Conducteur.SetRange("Code conducteur", rec."Code Conducteur");
                if Conducteur.FindFirst() then begin
                    rec."Driver Name" := Conducteur."NOM DU CONDUCTEUR";
                end;
            end;
        }
        field(50018; "Centre Logistique"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50019; "Description Centre Logistique"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; Matricule_Autre; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; Description_Client_Fournisseur; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description Client/Fournisseur';
        }

        field(50022; imprime; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Imprimé';
        }
        field(50023; UserName; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; CodeMultiPese; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60016; RacineBalance; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(55005; Statut_Total_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entièrement payé';
        }
        field(55006; Ticket_Concerne; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s) Planteur';
        }
        field(55007; NumDocExten; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Paiement Régime';
        }
        field(55008; Telephone; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(55009; En_Attente_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'En attente de paiement';
            trigger OnValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then begin
                    // UserSetup.TestField(UserSetup.EnAttentePaiement, true);
                end;
            end;
        }
        field(55010; TotalPlanteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur (FCFA)';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55011; Impot; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Impôt 1,5 %';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55012; TotalPlanteurTTc; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur(TTC:) FCFA';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55013; TotalTransPorteurTTC; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat Transporteur (TTC:) FCFA';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55014; Poids_Total; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Poids Total';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55015; Ticket_Concerne_Transport; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s) Transporteur';
        }
        field(55016; PrixUnitaire; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix unitaire(FCFA)';
            DecimalPlaces = 6;
            Editable = false;
        }
        field(55017; Marqueur; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55018; NaturePiece; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'NATURE DE LA PIECE';
            OptionMembers = CNI,PASSEPORT,PERMIS,CS,AUTRES;
        }
        field(55019; PrixUnitaireTansport; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Prix unitaire Transport(FCFA)';
            DecimalPlaces = 6;
            Editable = FALSE;
        }
        field(55020; MarqueurTransport; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55021; TotalTransporteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat Transport (FCFA)';
            Editable = false;
            DecimalPlaces = 6;
        }
        field(55022; TestToal; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(55023; Annule; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Envoyé en annulation","Annulation refusée","Annulé","Autorisé à être annulé";

            // Caption = 'Annulé';
        }
        field(55024; "Envoyé en annulation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55025; "Autorisé à être annulé"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55026; TicketAnnule; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55027; NumeroPaiementTransport; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Paiement Transport';
        }
        field(55028; CLpaiement; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(55029; NumeroDocTransport; CODE[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Paiement Transport';
        }



    }

    keys
    {
        key(Key1; TICKET, "Row No.", RowID)
        {
            Clustered = true;
        }
        key(Key2; "Ticket Planteur")
        {
        }
        key(Key3; RowID)
        {
        }
        // key(Key4; CodeIncrementAuto2)
        // {

        // }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "Ticket Planteur", "Code planteur", "Nom planteur", "Weighing 1 Date", "Vehicle Registration No.", "Item Origin", BonEnlevement)
        {
        }
    }

    // NoSeriesMgt: Codeunit NoSeriesManagement;

    // procedure AssistEdit_PointCaisse(OldPoint: Record "Item Weigh Bridge"): Boolean;
    // begin
    //     WITH PCaisse DO BEGIN
    //         PCaisse := Rec;
    //         "Param Caisse".Get();
    //         "Param Caisse".TESTFIELD("N° souhe Appro");
    //         IF NoSeriesMgt.SelectSeries("Param Caisse"."N° souhe Appro", OldPoint."No. Series", "No. Series") THEN BEGIN
    //             "Param Caisse".Get();
    //             "Param Caisse".TESTFIELD("N° souche Ouverture");
    //             NoSeriesMgt.SetSeries("No.");
    //             Rec := PCaisse;
    //             EXIT(TRUE);
    //         END;
    //     END;
    // end;
    /*FnGeek
    procedure AssistEdit_PointCaisse(OldPoint: Record "Item Weigh Bridge"): Boolean;
    var
        Balance: Record Balance;
        TicketPlanteur: Code[100];
    begin
        WITH PCaisse DO BEGIN
            PCaisse := Rec;
            Message('aaa: %1',rec."Balance Code" );
            "Param Caisse".SetRange(Code, rec."Balance Code");
            if "Param Caisse".FindFirst() then begin
                Message('Le numéro de souche existe');
                // rec.TestField("Balance Code");

                // if "Ticket Planteur" <> xRec."Ticket Planteur" then begin
                /**FnGeek à conserver
                "Param Caisse".Get();
                NoSeriesMgt.TestManual("Param Caisse"."N° souhe Appro");
                "No. Series" := '';
                ***/
    // Balance.SetRange(Code, rec."Balance Code");
    // if Balance.FindFirst() then begin

    // NoSeriesMgt.GetLastNoUsed(Balance."Souche N°");
    // "Ticket Planteur" := NoSeriesMgt.GetNextNo(Balance."Souche N°", WorkDate(), true);
    //  Message('eee: %1', "Ticket Planteur");
    // end;
    /*if xRec."No Point" = '' then
        "Costing Method" := InvtSetup."Default Costing Method";*/
    // HRSetup.TESTFIELD(DmdeStageEmbauche);

    // end;
    // /**FnGeek 04_09_25
    //             IF NoSeriesMgt.SelectSeries("Param Caisse"."Souche N°", OldPoint."No. Series", "No. Series") THEN BEGIN
    //                 // "Param Caisse".Get();
    //                 // "Param Caisse".TESTFIELD("N° souche Ouverture");
    //                 // NoSeriesMgt.SetSeries("Ticket Planteur");
    //                 Message('Fabio come here');

    //                 TicketPlanteur := "Ticket Planteur";
    //                 NoSeriesMgt.SetSeries(TicketPlanteur);

    //                 Rec := PCaisse;
    //                 EXIT(TRUE);
    //             END;
    //         end else begin
    //             Error('Renseigner la souche de numéro sur la balance    ');
    //         end;

    //     END;
    // end;
    // */


    procedure AssistEdit_PointCaisse(OldPoint: Record "Item Weigh Bridge"): Boolean;
    var
        Balance: Record Balance;
        TicketPlanteur: Code[100];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        // Vérifier qu'une balance est sélectionnée
        // Rec.TestField("Balance Code");
        Balance.SetRange(Code, Rec."Balance Code");
        if not Balance.FindFirst() then
            Error('La balance avec le code %1 est introuvable.', Rec."Balance Code");
        if NoSeriesMgt.SelectSeries(Balance."Souche N°", OldPoint."No. Series", Rec."No. Series") then begin

            TicketPlanteur :=
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate(), true);

            Rec."Ticket Planteur" := TicketPlanteur;

            exit(true);
        end else begin
            Error('Impossible de sélectionner la souche de numérotation "%1".', Balance."Souche N°");
        end;
    end;
    //*******************************FnGeek 010125
    procedure AssistEdit_PointCaisses(OldPoint: Record "Item Weigh Bridge"): Boolean;
    var
        Balance: Record Balance;
        TicketPlanteur: Code[100];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParaTicket: Record "Parametres ticket";
    begin
        // Vérifier qu'une balance est sélectionnée
        // Rec.TestField("Balance Code");
        // Balance.SetRange(Code, Rec."Balance Code");
        ParaTicket.Get(1);
        Message('SSS:%1',ParaTicket.SoucheMultiPese);
        if not Balance.FindFirst() then
            Error('La balance avec le code %1 est introuvable.', Rec."Balance Code");
        if NoSeriesMgt.SelectSeries(ParaTicket.SoucheMultiPese, OldPoint."No. Series", Rec."No. Series") then begin

            TicketPlanteur :=
                NoSeriesMgt.GetNextNo(Rec."No. Series", WorkDate(), true);

            Rec.CodeMultiPese := TicketPlanteur;

            exit(true);
        end else begin
            Error('Impossible de sélectionner la souche de numérotation "%1".', Balance."Souche N°");
        end;
    end;




    //     local procedure InitInsert()
    //     var
    //         TransferHeader: Record "Item Weigh Bridge";
    //         // NoSeries: Codeunit "No. Series";
    //         Noseries: Codeunit "No. Series";
    // #if not CLEAN24
    //         NoSeriesManagement: Codeunit NoSeriesManagement;
    //         DefaultNoSeriesCode: Code[20];
    // #endif
    //         IsHandled: Boolean;
    //        // NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries//FnGeek A revoir
    //     begin
    //         IsHandled := false;
    //         // OnInitInsertOnBeforeInitSeries(xRec, IsHandled);
    //         if not IsHandled then
    //             if "Ticket Planteur" = '' then begin
    //                 TestNoSeries();
    // #if not CLEAN24
    //                 DefaultNoSeriesCode := GetNoSeriesCode();
    //                 NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(DefaultNoSeriesCode, xRec."No. Series", "Posting Date",  "Ticket Planteur", "No. Series", IsHandled);
    //                 if not IsHandled then begin
    //                     if NoSeries.AreRelated(DefaultNoSeriesCode, xRec."No. Series") then
    //                         "No. Series" := xRec."No. Series"
    //                     else
    //                         "No. Series" := DefaultNoSeriesCode;
    //                     "Ticket Planteur" := NoSeries.GetNextNo("No. Series", "Posting Date");
    //                     TransferHeader.ReadIsolation(IsolationLevel::ReadUncommitted);
    //                     TransferHeader.SetLoadFields("Ticket Planteur");
    //                     while TransferHeader.Get("Ticket Planteur") do
    //                         "Ticket Planteur" := NoSeries.GetNextNo("No. Series", "Posting Date");
    //                     NoSeriesManagement.RaiseObsoleteOnAfterInitSeries("No. Series", DefaultNoSeriesCode, "Posting Date", "Ticket Planteur");
    //                 end;
    // #else
    //                     if NoSeries.AreRelated(GetNoSeriesCode(), xRec."No. Series") then
    //                         "No. Series" := xRec."No. Series"
    //                     else
    //                         "No. Series" := GetNoSeriesCode();
    //                     "No." := NoSeries.GetNextNo("No. Series", "Posting Date");
    //                     TransferHeader.ReadIsolation(IsolationLevel::ReadUncommitted);
    //                     TransferHeader.SetLoadFields("No.");
    //                     while TransferHeader.Get("No.") do
    //                         "No." := NoSeries.GetNextNo("No. Series", "Posting Date");
    // #endif
    //             end;

    //         // OnInitInsertOnBeforeInitRecord(xRec);
    //         // InitRecord();
    //     end;

    local procedure TestNoSeries()
    var
        IsHandled: Boolean;
    begin
        // GetInventorySetup();
        IsHandled := false;
        // OnBeforeTestNoSeries(Rec, InvtSetup, IsHandled);
        if IsHandled then
            exit;
        InvtSetup.SetRange(Code, rec."Balance Code");
        InvtSetup.TestField("Souche N°");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
    begin
        GetInventorySetup();
        IsHandled := false;
        // OnBeforeGetNoSeriesCode(Rec, InvtSetup, NoSeriesCode, IsHandled);
        if IsHandled then
            exit(NoSeriesCode);
        InvtSetup.SetRange(Code, rec."Balance Code");
        if InvtSetup.FindFirst() then begin
            NoSeriesCode := InvtSetup."Souche N°";
        end;

        // OnAfterGetNoSeriesCode(Rec, NoSeriesCode);
        exit(NoSeriesCode);
    end;

    local procedure GetInventorySetup()
    begin
        if not HasInventorySetup then begin
            // InvtSetup.Get();
            InvtSetup.SetRange(Code, rec."Balance Code");
            HasInventorySetup := true;
        end;
    end;
    //Fabrice FnGeek 06_09_25
    // procedure AssistEdit(OldSalesHeader: Record "Sales Header") Result: Boolean
    // var
    //     SalesHeader2: Record "Sales Header";
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     // OnBeforeAssistEdit(Rec, OldSalesHeader, IsHandled, Result);
    //     if IsHandled then
    //         exit;

    //     with SalesHeader do begin
    //         Copy(Rec);
    //         // GetSalesSetup();
    //         TestNoSeries();
    //         if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldSalesHeader."No. Series", "No. Series") then begin
    //             if ("Balance Code" = '') then begin
    //                 // HideCreditCheckDialogue := false;
    //                 Rec.CheckCreditMaxBeforeInsert();
    //                 HideCreditCheckDialogue := true;
    //             end;
    //             NoSeriesMgt.SetSeries("No.");
    //             if SalesHeader2.Get("Document Type", "No.") then
    //                 Error(Text051, LowerCase(Format("Document Type")), "No.");
    //             Rec := SalesHeader;
    //             exit(true);
    //         end;
    //     end;
    // end;
    trigger OnInsert()
    var
        myInt: Integer;
        Balance: Record Balance;
    // Ticket
    begin
        // Message('HELLO');
        // Balance.SetRange(Code, 'AYENOUA2');
        // if Balance.FindFirst() then begin
        //     Message('Sch: %1', Balance."Souche N°");
        //     NoSeriesMgt.InitSeries(Balance."Souche N°", xRec."No. Series", 0D, "Ticket Planteur", "No. Series");
        // end;

    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

        PCaisse: Record "Item Weigh Bridge";
        "Param Caisse": Record Balance;
        InvtSetup: Record Balance;
        HasInventorySetup: Boolean;
        SalesHeader: Record "Item Weigh Bridge";
    //Fabrice FnGeek 06_09_25


}

