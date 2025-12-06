page 70118 Paiement_Header_Transporteur
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Entete_Paiement_Transporteur;
    InsertAllowed = true;
    ModifyAllowed = true;
    Caption = 'Multiple paiement Transporteur';

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

                        end;


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
            }
            group(Paiement)
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
                field(TotalPlanteurTT; TotalPlanteurTTc)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PoidTotalTransport; PoidTotalTransport)
                {
                    ApplicationArea = ll;
                    Editable = false;
                }
                field(TotalTransport; TotalTransport)
                {
                    ApplicationArea = ll;
                    Editable = false;
                }
                field(TotalTransportIMPOT; TotalTransportIMPOT)
                {
                    ApplicationArea = ll;
                    Editable = false;
                }
                field(TotalTransportTTC; TotalTransportTTC)
                {
                    ApplicationArea = ll;
                    Editable = false;
                }
            }
            part(Ligne_Paiement_Transporteur; Ligne_Paiement_Transporteur)
            {
                SubPageLink = "Code planteur" = field(Palanteur), "Statut paiement" = const(false), valide = const(true), En_Attente_Paiement = const(false), "Type opération" = const('ACHAT DIRECT');

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
                    EnteteHeader: Record Entete_Paiement_Transporteur;
                    Entete_Paiement: Record Entete_Paiement;
                    nudoc: Code[50];
                begin
                    if Confirm('Voulez vous valider le paiement') then begin
                        nudoc := Rec.NumDocExt;
                        ItemWeightBridge.SetFilter(Ticket_Concerne_Transport, '=%1', true);
                        ItemWeightBridge.SetFilter(NumDocExten, '=%1', rec.NumDocExt);
                        ItemWeightBridge.SetFilter("Statut paiement", '=%1', false);
                        if ItemWeightBridge.FindSet() then begin
                            repeat begin
                                PayerTransporteur(ItemWeightBridge);
                                TransactionsTransport(ItemWeightBridge);
                            end until ItemWeightBridge.Next() = 0;
                        end else begin
                            Error('Vous n''avez rien sélectionné');
                        end;
                        EnteteHeader.SetRange(NumDocExt, nudoc);
                        if EnteteHeader.FindFirst() then begin
                            Run(Page::ListePantTransporteurArchive, EnteteHeader);
                        end;
                    end else begin
                        exit
                    end;


                end;
            }
            action(Annuler)
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
                        REC.StatutAnnulaition := true;
                        rec.Modify();
                        transaction.Reset();
                        transaction.Init();
                        itemWeitg2.SetFilter(itemWeitg2.NumDocExten, '=%1', rec.NumDocExt);
                        itemWeitg2.SetFilter(itemWeitg2.Ticket_Concerne_Transport, '=%1', true);
                        itemWeitg2.SetFilter(itemWeitg2."Statut paiement", '=%1', true);
                        if itemWeitg2.FindSet() then begin
                            repeat begin
                                AnnulerTicketTransport(itemWeitg2);
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
                        itemWeitg.SetFilter(Ticket_Concerne_Transport, '=%1', true);
                        itemWeitg.SetFilter("Statut paiement", '=%1', true);
                        if itemWeitg.FindSet() then begin
                            repeat begin
                                itemWeitg."Statut paiement" := false;
                                itemWeitg.Statut_Total_Paiement := false;
                                itemWeitg.Ticket_Concerne_Transport := false;
                                itemWeitg.Date_Paiement := 0D;
                                itemWeitg.Modify();
                            end until itemWeitg.Next() = 0;
                        end;
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
            Message('a: %1 b: %2', ItemWeigBridge."Ticket Planteur", ItemWeigBridge."Statut paiement Planteur");
            Error('Ce ticket a été déja payé pour le planteur');
        end else begin
            ItemWeigBridge."Statut paiement Planteur" := true;
            ItemWeigBridge.NumDocExten := (ItemWeigBridge."Code planteur" + Format(rec.code_Paiement));
            ItemWeigBridge.Date_Paiement := WorkDate();
            ItemWeigBridge.Modify();
            // Message('yes1:%1', ItemWeigBridge."Statut paiement Planteur");
            TransFertTicketFromItemWeigntToBridgeCaisse(ItemWeigBridge);
            TicketPlanteur(ItemWeigBridge);
            if (ItemWeigBridge."Statut paiement" = true) OR (ItemWeigBridge."Type opération" = 'ACHAT COMPTANT') then begin
                ItemWeigBridge.Statut_Total_Paiement := true;
                ItemWeigBridge.Modify();
            end;
        end;
    end;

    procedure PayerTransporteur(ItemWeigBridge2: Record "Item Weigh Bridge")
    var
        myInt: Integer;
    begin
        if ItemWeigBridge2."Type opération" = 'ACHAT COMPTANT' then begin
            Error('On ne peut pas payer le transporteur car ce ticket est: ACHAT COMPTANT');
        end;
        if (ItemWeigBridge2."Statut paiement" = true) then begin
            Error('Ce ticket a été déja payé pour le transporteur');
        end else begin
            ItemWeigBridge2."Statut paiement" := true;
            ItemWeigBridge2.Date_Paiement := WorkDate();
            ItemWeigBridge2.NumDocExten := rec.NumDocExt;
            ItemWeigBridge2.Modify();
            //***
            rec.Archive := true;
            rec.Modify();
            //***
            TransFertTicketFromItemWeigntToBridgeCaisse(ItemWeigBridge2);
            TicketTransporteur(ItemWeigBridge2);
            if ItemWeigBridge2."Statut paiement Planteur" = true then begin
                ItemWeigBridge2.Statut_Total_Paiement := true;
                ItemWeigBridge2.Modify()
            end;
        end;
    end;

    procedure TicketTransporteur(ItemWeignt2: Record "Item Weigh Bridge")
    var
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.SetRange(TICKET, ItemWeignt2.TICKET);
        ItemWeighBridgecaisse.SetRange(RowID, ItemWeignt2.RowID);
        ItemWeighBridgecaisse.SetRange("Ticket Planteur");
        if ItemWeighBridgecaisse.FindLast() then begin
            ItemWeighBridgecaisse.EtatRegime := ItemWeignt2.EtatRegime;
            ItemWeighBridgecaisse.EtatTransport := 'PA';
            ItemWeighBridgecaisse."Ligne paiement trans" := TRUE;
            ItemWeighBridgecaisse."Ligne paiement" := ItemWeignt2."Ligne paiement";
            ItemWeighBridgecaisse.Modify()
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
        // ItemWeighBridgecaisse.DateRegime := Rec.Date_Paiement;
        ItemWeighBridgecaisse.DateTransport := rec.Date_Paiement;
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
            ItemWeighBridgecaisse."Ligne paiement" := true;
            ItemWeighBridgecaisse."Ligne paiement trans" := ItemWeignt."Ligne paiement trans";
            ItemWeighBridgecaisse.Modify()
        end;
    end;

    procedure TransactionsTransport(ItemWeigtn2: Record "Item Weigh Bridge")
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
        Transaction.Description := ItemWeigtn2."Ticket Planteur" + ':' + ' ' + ItemWeigtn2."Code Transporteur" + ' ' + ItemWeigtn2.ORIGINE;
        Transaction.Montant := -ItemWeigtn2.TotalTransport;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Message('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := ItemWeigtn2."Code Transporteur";
        Transaction.Nom := ItemWeigtn2."Nom Transporteur";
        Transaction."N° Document" := ItemWeigtn2."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := -ItemWeigtn2.TotalTransPorteurTTC;
        Transaction."Origine Operation" := ItemWeigtn2.ORIGINE;
        Transaction.DocExtern := ItemWeigtn2.NumDocExten;
        Transaction.Multipaiement := true;
        Transaction.Insert()
    end;

    procedure AnnulerTicketTransport(ItemWeigtn2: Record "Item Weigh Bridge")
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
        Transaction.Description := ItemWeigtn2."Ticket Planteur" + ':' + ' ' + ItemWeigtn2."Code Transporteur" + ' ' + ItemWeigtn2.ORIGINE;
        Transaction.Montant := ItemWeigtn2.TotalTransport;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Error('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := ItemWeigtn2."Code Transporteur";
        Transaction.Nom := ItemWeigtn2."Nom Transporteur";
        Transaction."N° Document" := ItemWeigtn2."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := ItemWeigtn2.TotalTransPorteurTTC;
        Transaction."Origine Operation" := ItemWeigtn2.ORIGINE;
        Transaction.DocExtern := ItemWeigtn2.NumDocExten;
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

    procedure CheckSolde()
    var
        Transaction: Record Transactions;
        total: Decimal;
    begin
        Clear(total);
        REC.CalcFields(TotalTransportTTC);
        Transaction.SetFilter("user id", '=%1', UserId);
        if Transaction.FindSet() then begin
            repeat begin
                total += Transaction."Montant NET";
            end until Transaction.Next() = 0;
            if rec.TotalTransportTTC > total then begin
                Error('Vous ne pouvez pas payer ce ticket de solde %1 car le solde de la caisse est %2', rec.TotalTransportTTC, total);
            end;
        end;
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
}