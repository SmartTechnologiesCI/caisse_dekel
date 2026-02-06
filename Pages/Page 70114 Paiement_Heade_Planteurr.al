page 70114 Paiement_Header
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Entete_Paiement;
    InsertAllowed = true;
    ModifyAllowed = true;
    Caption = 'Multiple paiement Planteur';

    layout
    {
        area(Content)
        {
            group(Général)
            {
                field(Code_Transporteur; Code_Transporteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetRange("Ticket Planteur", rec.Palanteur);
                        if ItemWeighBridge.FindFirst() then begin
                            rec.Nom_Planteur := Nom_Planteur;
                            rec.Date_Paiement := WorkDate();
                            REC.Caissier := UserId;
                            // rec.Modify()
                        end;
                        CurrPage.Update();

                    end;

                }
                field(Nom_Transporteur; Nom_Transporteur)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Palanteur; Palanteur)
                {
                    ApplicationArea = All;
                    // TableRelation = "Item Weigh Bridge"."Code planteur";
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetRange("Code planteur", rec.Palanteur);
                        if ItemWeighBridge.FindFirst() then begin
                            rec.Nom_Planteur := ItemWeighBridge."Nom planteur";
                            // rec.Modify();
                        end;


                    end;
                }
                field(Nom_Planteur; Nom_Planteur)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Beneficiare; Beneficiare)
                {
                    ApplicationArea = All;
                }
                field(NaturePiece; NaturePiece)
                {
                    ApplicationArea = All;
                }
                field(CNI; CNI)
                {
                    ApplicationArea = All;
                }
                field(Mode_Paiement; Mode_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Telephone; Telephone)
                {
                }

                field(Observation; Observation)
                {
                    ApplicationArea = All;
                }
                field(Date_Paiement; Date_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Caissier; Caissier)
                {
                    ApplicationArea = All;
                }
                field(NumDocExt; NumDocExt)
                {
                    ApplicationArea = All;
                }
                field(TotalFictif; TotalFictif)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

            }
            group(Paie)
            {
                field(Poids_Total; Poids_Total)
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field(TotalPlanteur; TotalPlanteur)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Impot; Impot)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(TotalPlanteurTTc; TotalPlanteurTTc)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PoidTotalRegime; PoidTotalRegime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalRegime; TotalRegime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalRegimeIMPOT; TotalRegimeIMPOT)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalRegimeTTC; TotalRegimeTTC)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Ligne_Paiement; Ligne_Paiement)
            {
                SubPageLink = "Code planteur" = field(Palanteur), "Statut paiement Planteur" = const(false), valide = const(true), En_Attente_Paiement = const(false), "Type opération" = const('ACHAT DIRECT|ACHAT COMPTANT');

            }
            part(TotauxCardPage; TotauxCardPage)
            {
                Visible = false;
                Caption = 'Paiement';
                SubPageLink = "Code planteur" = field(Palanteur), "Statut paiement Planteur" = const(false), Ticket_Concerne = const(false);

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Caption = 'Valider paiement';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ItemWeightBridge: Record "Item Weigh Bridge";
                    ItemWeightBridge2: Record "Item Weigh Bridge";
                    ItemWeightBridge1: Record "Item Weigh Bridge";
                    EnteteHeader: Record Entete_Paiement;
                    ItemWeightBridgeAnnuler: Record "Item Weigh Bridge";
                    nudoc: code[50];
                    Entete_Paiement: Record Entete_Paiement;
                    Vendor: Record Vendor;
                begin
                    Vendor.SetRange("No.", rec.Palanteur);
                    if Vendor.FindFirst() then begin
                        if Vendor.Statut <> Vendor.Statut::"Validé" then begin
                            Error('Ce planteur n''est pas validé');
                        end;
                    end;
                    if Confirm('Voulez vous valider le paiement') then begin
                        nudoc := rec.NumDocExt;
                        rec.TestField(rec.Beneficiare);
                        rec.TestField(rec.Telephone);
                        rec.TestField(CNI);
                        ItemWeightBridge1.SetFilter(Ticket_Concerne, '=%1', true);
                        ItemWeightBridge1.SetFilter(NumDocExten, '=%1', rec.NumDocExt);
                        ItemWeightBridge1.SetFilter("Statut paiement Planteur", '=%1', false);
                        if ItemWeightBridge1.FindSet() then begin
                            repeat begin
                                ItemWeightBridge1.TestField(TotalPlanteur);
                                ItemWeightBridge1.TestField(TotalPlanteurTTc);
                                ItemWeightBridge1.TestField(Beneficiaire);
                                ItemWeightBridge1.TestField(NCNI);
                                ItemWeightBridge1.TestField(Telephone);
                                ItemWeightBridge1.TestField(TicketAnnule, false);
                            end until ItemWeightBridge1.Next() = 0;
                        end;
                        ItemWeightBridge.SetFilter(Ticket_Concerne, '=%1', true);
                        ItemWeightBridge.SetFilter(NumDocExten, '=%1', rec.NumDocExt);
                        ItemWeightBridge.SetFilter("Statut paiement Planteur", '=%1', false);
                        if ItemWeightBridge.FindSet() then begin
                            repeat begin
                                PayerPlanteur(ItemWeightBridge);
                                Transactionsplanteur(ItemWeightBridge);
                            end until ItemWeightBridge.Next() = 0;
                        end else begin
                            Error('Vous n''avez rien sélectionné');
                        end;
                        Entete_Paiement.SetRange(NumDocExt, nudoc);
                        if Entete_Paiement.FindFirst() then begin
                            Run(Page::ListePantPlanteurArchive, Entete_Paiement);
                        end;
                    end else begin
                        exit
                    end;



                end;
            }
            action(Annuleryyyyy)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                trigger OnAction()
                var
                    ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
                    itemWeitg: Record "Item Weigh Bridge";
                    transaction: Record Transactions;
                    itemWeitg2: Record "Item Weigh Bridge";
                begin
                    if Confirm('vouslez vous annuler ce ticket') then begin

                        // transaction.Reset();
                        // transaction.Init();
                        itemWeitg2.SetFilter(itemWeitg2.NumDocExten, '=%1', rec.NumDocExt);
                        itemWeitg2.SetFilter(itemWeitg2.Ticket_Concerne, '=%1', true);
                        itemWeitg2.SetFilter("Statut paiement Planteur", '=%1', true);
                        if itemWeitg2.FindSet() then begin
                            repeat begin
                                Message('num: %1', itemWeitg2.NumDocExten);
                                AnnulationTicket(itemWeitg2);
                            end until itemWeitg2.Next() = 0;
                        end;

                        ItemWeighBridgecaisse.Reset();
                        ItemWeighBridgecaisse.Init();
                        ItemWeighBridgecaisse.SetFilter(ItemWeighBridgecaisse.NuDocExtern, '=%1', rec.NumDocExt);
                        if ItemWeighBridgecaisse.FindSet() then begin
                            repeat begin
                                ItemWeighBridgecaisse.Delete();
                            end until ItemWeighBridgecaisse.Next() = 0;
                        end;

                        // itemWeitg.SetFilter(NumDocExten, rec.NumDocExt);
                        itemWeitg.SetFilter(NumDocExten, '=%1', rec.NumDocExt);
                        itemWeitg.SetFilter(Ticket_Concerne, '=%1', true);
                        itemWeitg.SetFilter("Statut paiement Planteur", '=%1', true);
                        if itemWeitg.FindSet() then begin
                            repeat begin
                                // itemWeitg."Statut paiement" := false;
                                itemWeitg.Ticket_Concerne := false;
                                itemWeitg."Statut paiement Planteur" := false;
                                itemWeitg.Statut_Total_Paiement := false;
                                itemWeitg.Date_Paiement := 0D;
                                itemWeitg.Modify();
                            end until itemWeitg.Next() = 0;
                        end;
                        REC.StatutAnnulaition := true;
                        rec.Modify();
                        Message('Annulation effectué avec succès');
                    end else begin
                        exit
                    end;
                end;
            }
        }

    }
    procedure PayerPlanteur(ItemWeigBridge: Record "Item Weigh Bridge")
    var
        myInt: Integer;
    begin
        if ItemWeigBridge."Statut paiement Planteur" = true then begin
            // Message('a: %1 b: %2', ItemWeigBridge."Ticket Planteur", ItemWeigBridge."Statut paiement Planteur");
            Error('Ce ticket a été déja payé pour le planteur');
        end else begin
            ItemWeigBridge."Statut paiement Planteur" := true;
            ItemWeigBridge.NumDocExten := rec.NumDocExt;
            ItemWeigBridge.Date_Paiement := WorkDate();
            ItemWeigBridge.Modify();
            //**
            rec.Archive := true;
            REC.Modify();
            //**
            // Message('yes1:%1', ItemWeigBridge."Statut paiement Planteur");
            TransFertTicketFromItemWeigntToBridgeCaisse(ItemWeigBridge);
            TicketPlanteur(ItemWeigBridge);
            if (ItemWeigBridge."Statut paiement" = true) OR (ItemWeigBridge."Type opération" = 'ACHAT COMPTANT') then begin
                ItemWeigBridge.Statut_Total_Paiement := true;
                ItemWeigBridge.Modify();
            end;
        end;
    end;

    procedure TransFertTicketFromItemWeigntToBridgeCaisse(ItemWeigthBridge: Record "Item Weigh Bridge")
    var
        myInt: Integer;
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.Reset();
        ItemWeighBridgecaisse.Init();
        ItemWeighBridgecaisse.TICKET := ItemWeigthBridge.TICKET;
        ItemWeighBridgecaisse."Vehicle Registration No." := ItemWeigthBridge."Vehicle Registration No.";
        ItemWeighBridgecaisse."Driver Name" := ItemWeigthBridge."Driver Name";
        ItemWeighBridgecaisse."Item Origin" := ItemWeigthBridge."Item Origin";
        ItemWeighBridgecaisse.BonEnlevement := ItemWeigthBridge.BonEnlevement;
        ItemWeighBridgecaisse."POIDS ENTREE" := ItemWeigthBridge."POIDS ENTREE";
        ItemWeighBridgecaisse."POIDS SORTIE" := ItemWeigthBridge."POIDS SORTIE";
        ItemWeighBridgecaisse."POIDS NET" := ItemWeigthBridge."POIDS NET";
        // ItemWeighBridgecaisse."Row No." := rec."Row No.";//FnGeek 18_11_25
        ItemWeighBridgecaisse."Type opération" := ItemWeigthBridge."Type opération";
        ItemWeighBridgecaisse.Transporteur := ItemWeigthBridge.Transporteur;
        ItemWeighBridgecaisse.Uploaded := ItemWeigthBridge.Uploaded;
        ItemWeighBridgecaisse."Weighing 1 Date" := ItemWeigthBridge."Weighing 1 Date";
        ItemWeighBridgecaisse."Weighing 2 Date" := ItemWeigthBridge."Weighing 2 Date";
        ItemWeighBridgecaisse."Weighing 1 Hour" := ItemWeigthBridge."Weighing 1 Hour";
        ItemWeighBridgecaisse."Weighing 2 Hour" := ItemWeigthBridge."Weighing 2 Hour";
        ItemWeighBridgecaisse."Type of Transportation" := ItemWeigthBridge."Type of Transportation";
        ItemWeighBridgecaisse."Purchase Order Created" := ItemWeigthBridge."Purchase Order Created";
        ItemWeighBridgecaisse."Code planteur" := ItemWeigthBridge."Code planteur";
        ItemWeighBridgecaisse."Nom planteur" := ItemWeigthBridge."Nom planteur";
        ItemWeighBridgecaisse."Ticket Planteur" := ItemWeigthBridge."Ticket Planteur";
        ItemWeighBridgecaisse."Code article" := ItemWeigthBridge."Code article";
        ItemWeighBridgecaisse."Désignation article" := ItemWeigthBridge."Désignation article";
        ItemWeighBridgecaisse."Code Transporteur" := ItemWeigthBridge."Code Transporteur";
        ItemWeighBridgecaisse."Nom Transporteur" := ItemWeigthBridge."Nom Transporteur";
        ItemWeighBridgecaisse."Purchase invoice Created" := ItemWeigthBridge."Purchase invoice Created";
        ItemWeighBridgecaisse."Purchase Invoice No." := ItemWeigthBridge."Purchase Invoice No.";
        ItemWeighBridgecaisse."Purchase invoice Created" := ItemWeigthBridge."Purchase invoice Created";
        ItemWeighBridgecaisse."TPurchase Invoice No." := ItemWeigthBridge."TPurchase Invoice No.";
        ItemWeighBridgecaisse.RowID := ItemWeigthBridge.RowID;
        ItemWeighBridgecaisse."Code Client" := ItemWeigthBridge."Code Client";
        ItemWeighBridgecaisse."Nom Client" := ItemWeigthBridge."Nom Client";
        ItemWeighBridgecaisse."Sales invoice Created" := ItemWeigthBridge."Sales invoice Created";
        ItemWeighBridgecaisse."Sales Invoice No." := ItemWeigthBridge."Sales Invoice No.";
        ItemWeighBridgecaisse."Code magasin" := ItemWeigthBridge."Code magasin";
        ItemWeighBridgecaisse."N° Commande PIC" := ItemWeigthBridge."N° Commande PIC";
        ItemWeighBridgecaisse.ValeurAIPH := ItemWeigthBridge.ValeurAIPH;
        ItemWeighBridgecaisse.TotalRegime := ItemWeigthBridge.TotalRegime;
        ItemWeighBridgecaisse.TauxOPAR := ItemWeigthBridge.TauxOPAR;
        ItemWeighBridgecaisse.TotalOPAR := ItemWeigthBridge.TotalOPAR;
        ItemWeighBridgecaisse.TauxImpotRegime := ItemWeigthBridge.TauxImpotRegime;
        ItemWeighBridgecaisse.ValeurImpotRegime := ItemWeigthBridge.ValeurImpotRegime;
        ItemWeighBridgecaisse.MontantNetRegime := ItemWeigthBridge.MontantNetRegime;
        ItemWeighBridgecaisse.ValeurTransport := ItemWeigthBridge.ValeurTransport;
        ItemWeighBridgecaisse.TotalTransport := ItemWeigthBridge.TotalTransport;
        ItemWeighBridgecaisse.TauxOPAT := ItemWeigthBridge.TauxOPAT;
        ItemWeighBridgecaisse.TotalOPAT := ItemWeigthBridge.TotalOPAT;
        ItemWeighBridgecaisse.TauxImpotTransp := ItemWeigthBridge.TauxImpotTransp;
        ItemWeighBridgecaisse.ValeurImpoTransp := ItemWeigthBridge.ValeurImpoTransp;
        ItemWeighBridgecaisse.MontantNetTransp := ItemWeigthBridge.MontantNetTransp;
        ItemWeighBridgecaisse.DateRegime := Rec.Date_Paiement;
        // ItemWeighBridgecaisse.DateTransport := Rec.Date_Paiement;
        ItemWeighBridgecaisse.NumeroRegime := ItemWeigthBridge.NumeroRegime;
        ItemWeighBridgecaisse.NumeroTransp := ItemWeigthBridge.NumeroTransp;
        ItemWeighBridgecaisse."Traitement effectué" := ItemWeigthBridge."Traitement effectué";
        ItemWeighBridgecaisse.Commentaire := ItemWeigthBridge.Commentaire;
        ItemWeighBridgecaisse.ValautoDateTime := ItemWeigthBridge.ValautoDateTime;
        ItemWeighBridgecaisse.CommentaireT := ItemWeigthBridge.CommentaireT;

        ItemWeighBridgecaisse.ETATID := ItemWeigthBridge.ETATID;
        ItemWeighBridgecaisse.ORIGINE := ItemWeigthBridge.ORIGINE;
        ItemWeighBridgecaisse.Doublon := ItemWeigthBridge.Doublon;
        //*****Added by FnGeek****************
        ItemWeighBridgecaisse."Ticket annule" := ItemWeigthBridge."Ticket annule";
        ItemWeighBridgecaisse."Transporteur dekel" := ItemWeigthBridge."Transporteur dekel";
        ItemWeighBridgecaisse."Planteur paye" := ItemWeigthBridge."Planteur paye";
        ItemWeighBridgecaisse."Transporteur paye" := ItemWeigthBridge."Transporteur paye";
        ItemWeighBridgecaisse."Balance Code" := ItemWeigthBridge."Balance Code";
        ItemWeighBridgecaisse."Process Ticket" := ItemWeigthBridge."Process Ticket";
        ItemWeighBridgecaisse."Client/Fournisseur" := ItemWeigthBridge."Client/Fournisseur";
        ItemWeighBridgecaisse."Type Vehicule" := ItemWeigthBridge."Type Vehicule";
        ItemWeighBridgecaisse.valide := ItemWeigthBridge.valide;
        ItemWeighBridgecaisse."Date validation" := ItemWeigthBridge."Date validation";
        ItemWeighBridgecaisse."Statut paiement" := ItemWeigthBridge."Statut paiement";
        ItemWeighBridgecaisse."Statut paiement Planteur" := ItemWeigthBridge."Statut paiement Planteur";
        ItemWeighBridgecaisse.CodeIncrementAuto := ItemWeigthBridge.CodeIncrementAuto;
        ItemWeighBridgecaisse.CodeIncrementAuto2 := ItemWeigthBridge.CodeIncrementAuto2;
        ItemWeighBridgecaisse."Nombre de planteurs" := ItemWeigthBridge."Nombre de planteurs";
        ItemWeighBridgecaisse.MultiPese := ItemWeigthBridge.MultiPese;
        ItemWeighBridgecaisse."No. Series" := ItemWeigthBridge."No. Series";
        ItemWeighBridgecaisse."Posting Date" := ItemWeigthBridge."Posting Date";
        ItemWeighBridgecaisse.Statut_Total_Paiement := ItemWeigthBridge.Statut_Total_Paiement;
        ItemWeighBridgecaisse.Date_Paiement := WorkDate();
        ItemWeighBridgecaisse.NuDocExtern := ItemWeigthBridge.NumDocExten;
        ItemWeighBridgecaisse.Insert()
    end;

    procedure TicketPlanteur(ItemWeignt: Record "Item Weigh Bridge")
    var
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.SetRange(TICKET, ItemWeignt.TICKET);
        ItemWeighBridgecaisse.SetRange(RowID, ItemWeignt.RowID);
        ItemWeighBridgecaisse.SetRange("Ticket Planteur");
        if ItemWeighBridgecaisse.FindLast() then begin
            ItemWeighBridgecaisse.EtatRegime := 'PA';
            ItemWeighBridgecaisse.EtatTransport := ItemWeignt.EtatTransport;
            // ItemWeighBridgecaisse."Ligne paiement" := true;//****FnGeek 30_01_26
            // ItemWeighBridgecaisse."Ligne paiement trans" := ItemWeignt."Ligne paiement trans";//****FnGeek 30_01_26
            ItemWeighBridgecaisse.Modify()
        end;
    end;

    procedure Transactionsplanteur(ItemWeigtn: Record "Item Weigh Bridge")
    var
        myInt: Integer;
        Transaction: Record Transactions;
        Caisse: Record Caisse;
    begin
        Transaction.Reset();
        Transaction.Init();
        Transaction.Source := Transaction.Source::"E/S";
        Transaction.Date := WorkDate();
        Transaction.Heure := Time;
        Transaction.Description := ItemWeigtn."Ticket Planteur" + ':' + ' ' + ItemWeigtn."Code planteur" + ' ' + ItemWeigtn.ORIGINE;
        Transaction.Montant := -rec.TotalPlanteur;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Error('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := ItemWeigtn."Code planteur";
        Transaction.Nom := ItemWeigtn."Nom planteur";
        Transaction."N° Document" := ItemWeigtn."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := -ItemWeigtn.TotalPlanteurTTc;
        Transaction."Origine Operation" := ItemWeigtn.ORIGINE;
        Transaction.DocExtern := ItemWeigtn.NumDocExten;
        Transaction.Multipaiement := true;
        Transaction.Insert()
    end;

    procedure CheckCaissier()
    var
        myInt: Integer;
        Caisse: Record Caisse;
    begin
        Caisse.SetRange("User ID", UserId);
        if not Caisse.FindFirst() then begin
            Error('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
    end;

    procedure AnnulationTicket(ItemWeigtn: Record "Item Weigh Bridge")
    var
        myInt: Integer;
        Transaction: Record Transactions;
        Caisse: Record Caisse;
    begin
        Transaction.Reset();
        Transaction.Init();
        Transaction.Source := Transaction.Source::"E/S";
        Transaction.Date := WorkDate();
        Transaction.Heure := Time;
        Transaction.Description := ItemWeigtn."Ticket Planteur" + ':' + ' ' + ItemWeigtn."Code planteur" + ' ' + ItemWeigtn.ORIGINE;
        Transaction.Montant := rec.TotalPlanteur;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Error('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := ItemWeigtn."Code planteur";
        Transaction.Nom := ItemWeigtn."Nom planteur";
        Transaction."N° Document" := ItemWeigtn."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := ItemWeigtn.TotalPlanteurTTc;
        Transaction."Origine Operation" := ItemWeigtn.ORIGINE;
        Transaction.DocExtern := ItemWeigtn.NumDocExten;
        Transaction.Multipaiement := true;
        Transaction.Insert()
    end;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        REC.Date_Paiement := WorkDate();
        rec.Caissier := UserId;
    end;

    var
        myInt: Integer;
        DocExterne: Code[50];
        TotalFictif: Decimal;
}