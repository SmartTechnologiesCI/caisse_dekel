page 70112 "Paiement Ticket"
{
    ApplicationArea = All;
    Caption = 'Paiement';
    PageType = Card;
    SourceTable = "Item Weigh Bridge";
    // InsertAllowed = false;
    ModifyAllowed = true;
    layout
    {

        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(MultiPese; rec.MultiPese)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Nombre de planteurs"; Rec."Nombre de planteurs")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Balance Code"; Rec."Balance Code")
                {
                    ToolTip = 'Specifies the value of the Balance Code field.', Comment = '%';
                    Editable = false;
                    Visible = false;
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit_PointCaisse(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                //<<Fabrice Smart 05_03_25
                field("Client/Fournisseur"; rec."Client/Fournisseur")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Code article"; rec."Code article")
                {
                    ApplicationArea = All;
                    TableRelation = Item;
                    Editable = false;
                    Visible = false;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Item: Record Item;
                    begin
                        Item.SetRange("No.", rec."Code article");
                        if Item.FindFirst() then begin
                            rec."Désignation article" := Item.Description;
                        end;
                    end;
                }
                field("Désignation article"; REC."Désignation article")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(ORIGINE; rec.ORIGINE)
                {
                    Editable = false;
                    ApplicationArea = All;
                    TableRelation = Origine.Origine;
                    Visible = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Origine: Record Origine;
                    begin
                        Origine.SetRange(Origine, rec.ORIGINE);
                        if Origine.FindFirst() then begin
                            REC."Item Origin" := Origine.Origine;
                            REC.Modify()
                        end;
                    end;
                }
                field("Type Vehicule"; REC."Type Vehicule")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Editable = false;
                    TableRelation = "Type Vehicule"."Matricule Vehicule";
                }
                field("Vehicle Registration No."; "Vehicle Registration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code Transporteur"; REC."Code Transporteur")
                {
                    ApplicationArea = All;
                    TableRelation = Vendor;
                    Editable = false;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Vend: Record Vendor;
                    begin
                        Vend.SetRange("No.", rec."Code Transporteur");
                        if Vend.FindFirst() then begin
                            rec."Nom Transporteur" := Vend.Name;
                        end;
                    end;
                }
                field("Nom Transporteur"; REC."Nom Transporteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Type opération"; Rec."Type opération")
                {
                    ToolTip = 'Specifies the value of the Type opération field.', Comment = '%';
                    TableRelation = "Type operation"."Type Operation";
                    Editable = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        TypeOperation: Record "Type operation";
                    begin
                        TypeOperation.SetRange("Type Operation", rec."Type opération");
                        if TypeOperation.FindFirst() then begin
                            rec."Type of Transportation" := TypeOperation.Mouvement;
                            REC.Modify();
                        end;
                    end;
                }
                field("Type of Transportation"; rec."Type of Transportation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                    // TableRelation = Vendor where("Vendor Posting Group"=const(''));
                    Editable = false;
                    // Enabled = rec.MultiPese;
                    TableRelation = Vendor;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Vend: Record Vendor;
                    begin
                        Vend.SetRange("No.", rec."Code planteur");
                        if Vend.FindFirst() then begin
                            rec."Nom planteur" := Vend.Name;
                        end;
                    end;
                }
                field("Nom planteur"; Rec."Nom planteur")
                {
                    ToolTip = 'Specifies the value of the Nom planteur field.', Comment = '%';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code magasin"; "Code magasin")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                //<<Fabrice Smart 05_03_25
                field("Ticket Planteur"; Rec."Ticket Planteur")
                {
                    ToolTip = 'Specifies the value of the Ticket Planteur field.', Comment = '%';
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit_PointCaisse(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field("Item Origin"; Rec."Item Origin")
                {
                    ToolTip = 'Specifies the value of the Item Origin field.', Comment = '%';
                    Editable = false;
                }
                field(BonEnlevement; REC.BonEnlevement)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("N° Commande PIC"; "N° Commande PIC")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Process Ticket"; rec."Process Ticket")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Statut paiement"; "Statut paiement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Statut paiement Planteur"; "Statut paiement Planteur")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Statut_Total_Paiement; Statut_Total_Paiement)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(En_Attente_Paiement; En_Attente_Paiement)
                {
                    ApplicationArea = All;
                    //FnGeek*****
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        // Message('eee:%1', rec.Mode_Paiement);
                        if ((REC.Mode_Paiement = rec.Mode_Paiement::ESPECE) or (REC.Mode_Paiement = rec.Mode_Paiement::"MOOV Money") or (REC.Mode_Paiement = rec.Mode_Paiement::"MTN Money") or (REC.Mode_Paiement = rec.Mode_Paiement::OM) or (REC.Mode_Paiement = rec.Mode_Paiement::Push) or (REC.Mode_Paiement = rec.Mode_Paiement::WAVE)) then begin
                            if REC.En_Attente_Paiement = TRUE then begin
                                Error('Le mode de paiement est différent de CHEQUE ou VIREMENT');
                            end;
                        end;
                        // if ( REC.Mode_Paiement <> rec.Mode_Paiement::Virement) then begin
                        //     Error('Le mode de paiement est différent de CHEQUE ou VIREMENT');
                        // end;
                    end;

                }
                // field("Code planteur"; Rec."Code planteur")
                // {
                //     ToolTip = 'Specifies the value of the Code planteur field.', Comment = '%';
                // }

            }
            group(Paiement)
            {
                field(Beneficiaire; rec.Beneficiaire)
                {
                    ApplicationArea = All;
                }
                field(NaturePiece; NaturePiece)
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        // rec.Modify();
                        // CurrPage.Update();
                    end;
                }

                field(NCNI; rec.NCNI)
                {
                    ApplicationArea = All;
                    Caption = 'N° de pièce';
                }
                field(Mode_Paiement; rec.Mode_Paiement)
                {
                    ApplicationArea = All;

                }
                field(Observation; rec.Observation)
                {
                    ApplicationArea = All;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = All;
                }

            }
            group(Poids)
            {
                field("POIDS ENTREE"; Rec."POIDS ENTREE")
                {
                    ToolTip = 'Specifies the value of the POIDS ENTREE field.', Comment = '%';
                    Editable = false;
                }
                field("POIDS SORTIE"; Rec."POIDS SORTIE")
                {
                    ToolTip = 'Specifies the value of the POIDS SORTIE field.', Comment = '%';
                    Editable = false;
                }
                //<<Fabrice Smart 05_03_25
                field("POIDS NET"; rec."POIDS NET")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Impot; Impot)
                {
                    ApplicationArea = All;
                }
                field(PrixUnitaire; PrixUnitaire)
                {
                    ApplicationArea = All;
                    Caption = 'Prix Unitaire planteur (FCFA)';
                }
                field(PrixUnitaireTansport; PrixUnitaireTansport)
                {
                    ApplicationArea = All;
                }

                field(Total; Total)
                {
                    ApplicationArea = All;
                    Caption = 'Total Achat Transporteur';
                    Editable = false;
                }
                field(TotalPlanteur; TotalPlanteur)
                {
                    ApplicationArea = aLL;
                    Editable = false;
                }
                field(TotalPlanteurTTc; TotalPlanteurTTc)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalTransPorteurTTC; TotalTransPorteurTTC)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                //<<Fabrice Smart 05_03_25
            }
            // part(MultiPeseSubForm; MultiPeseSubForm)
            // {
            //     SubPageLink = TICKET = field(TICKET), CodeIncrementAuto = field(CodeIncrementAuto);

            // }
        }


    }

    actions
    {
        area(processing)
        {
            group(Paiement)
            {
                action(Paiement_Planteur)
                {
                    Caption = 'Payer le planteur';
                    ApplicationArea = All;
                    Visible = PaiementVisiblePlanteur;

                    trigger OnAction()
                    var
                        Ticket: Record "Item Weigh Bridge";
                        ItemWeighBridge: Record "Item Weigh Bridge";

                    begin
                        if Confirm('Voulez vous valider le paiement') then begin
                            rec.TestField(En_Attente_Paiement, false);
                            // CheckSoldePlanteur();
                            Clear(Ticket1);
                            Clear(rowno1);
                            Clear(ROWID1);
                            Clear(TicketPlanteur1);
                            Ticket1 := rec.TICKET;
                            ROWID1 := rec.RowID;
                            rowno1 := rec."Row No.";
                            TicketPlanteur1 := rec."Ticket Planteur";
                            PayerPlanteur();
                            Transactionsplanteur();
                            ItemWeighBridge.SetRange(TICKET, Ticket1);
                            ItemWeighBridge.SetRange("Ticket Planteur", TicketPlanteur1);
                            ItemWeighBridge.SetRange("Row No.", rowno1);
                            ItemWeighBridge.SetRange(RowID, ROWID1);
                            if ItemWeighBridge.FindFirst() then begin
                                Page.Run(page::"Paiement Valide", ItemWeighBridge);
                            end;
                        end else begin
                            exit
                        end;



                    end;

                }
                action(Paiement_Transpoteur)
                {
                    Caption = 'Payer le transport';
                    ApplicationArea = All;
                    Visible = PaiementVisibleTransporteur;
                    trigger OnAction()
                    var
                        Ticket: Record "Item Weigh Bridge";
                        ticket1: Integer;
                        row: Integer;
                        ticketplanteur: code[50];
                        rowid1: Integer;
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        if Confirm('Voulez vous valider le paiement') then begin
                            rec.TestField(En_Attente_Paiement, false);
                            // CheckSoldePTransPort();
                            Clear(Ticket1);
                            Clear(rowno1);
                            Clear(ROWID1);
                            Clear(TicketPlanteur1);
                            Ticket1 := rec.TICKET;
                            ROWID1 := rec.RowID;
                            rowno1 := rec."Row No.";
                            TicketPlanteur1 := rec."Ticket Planteur";
                            PayerTransporteur();
                            TransactionsTransport();
                            ItemWeighBridge.SetRange(TICKET, Ticket1);
                            ItemWeighBridge.SetRange("Ticket Planteur", TicketPlanteur1);
                            ItemWeighBridge.SetRange("Row No.", rowno1);
                            ItemWeighBridge.SetRange(RowID, ROWID1);
                            if ItemWeighBridge.FindFirst() then begin
                                Page.Run(page::"Paiement Valide", ItemWeighBridge);
                            end;
                        end else begin
                            exit
                        end;

                    end;

                }
                action(Paiement_Planteur_Fournissuer)
                {
                    Caption = 'Payer le planteur & le transporteur';
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec."Statut paiement Planteur" := true;
                        rec."Statut paiement" := true;
                        REC.Statut_Total_Paiement := true;
                        rec.Modify();
                        if rec.Statut_Total_Paiement = true then begin
                            TransFertTicketFromItemWeigntToBridgeCaisse()
                        end;

                    end;

                }
                action(Recu_Paiement)
                {
                    Caption = 'Reçu Paiement';
                    ApplicationArea = All;

                    // RunObject = report Recu_Paiement;
                    trigger OnAction()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetRange(TICKET, Ticket1);
                        ItemWeighBridge.SetRange("Ticket Planteur", TicketPlanteur1);
                        ItemWeighBridge.SetRange("Row No.", rowno1);
                        ItemWeighBridge.SetRange(RowID, ROWID1);
                        if ItemWeighBridge.FindFirst() then begin
                            // (Report::Recu_Paiement,true, false, ItemWeighBridge."Ticket Planteur");
                            Report.Run(Report::Recu_Paiement, true, false, ItemWeighBridge);
                        end;
                    end;
                }
            }

        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(Paiement_Planteur_Promoted; Paiement_Planteur)
                {
                }
                actionref(Paiement_Transpoteur_Promoted; Paiement_Transpoteur)
                {
                }
                actionref(Paiement_Planteur_Fournissuer_Promoted; Paiement_Planteur_Fournissuer)
                {
                }
                actionref(Recu_Paiement_Promoted; Recu_Paiement)
                {
                }
            }
        }
    }
    procedure TransFertTicketFromItemWeigntToBridgeCaisse()
    var
        myInt: Integer;
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.Reset();
        ItemWeighBridgecaisse.Init();
        ItemWeighBridgecaisse.TICKET := rec.TICKET;
        ItemWeighBridgecaisse."Vehicle Registration No." := rec."Vehicle Registration No.";
        ItemWeighBridgecaisse."Driver Name" := rec."Driver Name";
        ItemWeighBridgecaisse."Item Origin" := rec."Item Origin";
        ItemWeighBridgecaisse.BonEnlevement := rec.BonEnlevement;
        ItemWeighBridgecaisse."POIDS ENTREE" := rec."POIDS ENTREE";
        ItemWeighBridgecaisse."POIDS SORTIE" := rec."POIDS SORTIE";
        ItemWeighBridgecaisse."POIDS NET" := rec."POIDS NET";
        // ItemWeighBridgecaisse."Row No." := rec."Row No.";//FnGeek 18_11_25
        ItemWeighBridgecaisse."Type opération" := rec."Type opération";
        ItemWeighBridgecaisse.Transporteur := rec.Transporteur;
        ItemWeighBridgecaisse.Uploaded := rec.Uploaded;
        ItemWeighBridgecaisse."Weighing 1 Date" := rec."Weighing 1 Date";
        ItemWeighBridgecaisse."Weighing 2 Date" := rec."Weighing 2 Date";
        ItemWeighBridgecaisse."Weighing 1 Hour" := rec."Weighing 1 Hour";
        ItemWeighBridgecaisse."Weighing 2 Hour" := rec."Weighing 2 Hour";
        ItemWeighBridgecaisse."Type of Transportation" := rec."Type of Transportation";
        ItemWeighBridgecaisse."Purchase Order Created" := rec."Purchase Order Created";
        ItemWeighBridgecaisse."Code planteur" := rec."Code planteur";
        ItemWeighBridgecaisse."Nom planteur" := rec."Nom planteur";
        ItemWeighBridgecaisse."Ticket Planteur" := rec."Ticket Planteur";
        ItemWeighBridgecaisse."Code article" := rec."Code article";
        ItemWeighBridgecaisse."Désignation article" := rec."Désignation article";
        ItemWeighBridgecaisse."Code Transporteur" := rec."Code Transporteur";
        ItemWeighBridgecaisse."Nom Transporteur" := rec."Nom Transporteur";
        ItemWeighBridgecaisse."Purchase invoice Created" := rec."Purchase invoice Created";
        ItemWeighBridgecaisse."Purchase Invoice No." := rec."Purchase Invoice No.";
        ItemWeighBridgecaisse."Purchase invoice Created" := rec."Purchase invoice Created";
        ItemWeighBridgecaisse."TPurchase Invoice No." := rec."TPurchase Invoice No.";
        ItemWeighBridgecaisse.RowID := rec.RowID;
        ItemWeighBridgecaisse."Code Client" := rec."Code Client";
        ItemWeighBridgecaisse."Nom Client" := rec."Nom Client";
        ItemWeighBridgecaisse."Sales invoice Created" := rec."Sales invoice Created";
        ItemWeighBridgecaisse."Sales Invoice No." := rec."Sales Invoice No.";
        ItemWeighBridgecaisse."Code magasin" := rec."Code magasin";
        ItemWeighBridgecaisse."N° Commande PIC" := rec."N° Commande PIC";
        ItemWeighBridgecaisse.ValeurAIPH := rec.ValeurAIPH;
        ItemWeighBridgecaisse.TotalRegime := rec.TotalRegime;
        ItemWeighBridgecaisse.TauxOPAR := rec.TauxOPAR;
        ItemWeighBridgecaisse.TotalOPAR := rec.TotalOPAR;
        ItemWeighBridgecaisse.TauxImpotRegime := rec.TauxImpotRegime;
        ItemWeighBridgecaisse.ValeurImpotRegime := rec.ValeurImpotRegime;
        ItemWeighBridgecaisse.MontantNetRegime := rec.MontantNetRegime;
        ItemWeighBridgecaisse.ValeurTransport := rec.ValeurTransport;
        ItemWeighBridgecaisse.TotalTransport := rec.TotalTransport;
        ItemWeighBridgecaisse.TauxOPAT := rec.TauxOPAT;
        ItemWeighBridgecaisse.TotalOPAT := rec.TotalOPAT;
        ItemWeighBridgecaisse.TauxImpotTransp := rec.TauxImpotTransp;
        ItemWeighBridgecaisse.ValeurImpoTransp := rec.ValeurImpoTransp;
        ItemWeighBridgecaisse.MontantNetTransp := rec.MontantNetTransp;
        ItemWeighBridgecaisse.DateRegime := Rec.Date_Paiement;
        ItemWeighBridgecaisse.DateTransport := Rec.Date_Paiement;
        ItemWeighBridgecaisse.NumeroRegime := rec.NumeroRegime;
        ItemWeighBridgecaisse.NumeroTransp := rec.NumeroTransp;
        ItemWeighBridgecaisse."Traitement effectué" := rec."Traitement effectué";
        ItemWeighBridgecaisse.Commentaire := rec.Commentaire;
        ItemWeighBridgecaisse.ValautoDateTime := rec.ValautoDateTime;
        ItemWeighBridgecaisse.CommentaireT := rec.CommentaireT;

        ItemWeighBridgecaisse.ETATID := rec.ETATID;
        ItemWeighBridgecaisse.ORIGINE := rec.ORIGINE;
        ItemWeighBridgecaisse.Doublon := REC.Doublon;
        //*****Added by FnGeek****************
        ItemWeighBridgecaisse."Ticket annule" := rec."Ticket annule";
        ItemWeighBridgecaisse."Transporteur dekel" := rec."Transporteur dekel";
        ItemWeighBridgecaisse."Planteur paye" := rec."Planteur paye";
        ItemWeighBridgecaisse."Transporteur paye" := rec."Transporteur paye";
        ItemWeighBridgecaisse."Balance Code" := rec."Balance Code";
        ItemWeighBridgecaisse."Process Ticket" := rec."Process Ticket";
        ItemWeighBridgecaisse."Client/Fournisseur" := rec."Client/Fournisseur";
        ItemWeighBridgecaisse."Type Vehicule" := rec."Type Vehicule";
        ItemWeighBridgecaisse.valide := rec.valide;
        ItemWeighBridgecaisse."Date validation" := rec."Date validation";
        ItemWeighBridgecaisse."Statut paiement" := rec."Statut paiement";
        ItemWeighBridgecaisse."Statut paiement Planteur" := rec."Statut paiement Planteur";
        ItemWeighBridgecaisse.CodeIncrementAuto := rec.CodeIncrementAuto;
        ItemWeighBridgecaisse.CodeIncrementAuto2 := rec.CodeIncrementAuto2;
        ItemWeighBridgecaisse."Nombre de planteurs" := rec."Nombre de planteurs";
        ItemWeighBridgecaisse.MultiPese := rec.MultiPese;
        ItemWeighBridgecaisse."No. Series" := rec."No. Series";
        ItemWeighBridgecaisse."Posting Date" := rec."Posting Date";
        ItemWeighBridgecaisse.Statut_Total_Paiement := rec.Statut_Total_Paiement;
        // ItemWeighBridgecaisse.DateRegime
        ItemWeighBridgecaisse.Date_Paiement := WorkDate();

        ItemWeighBridgecaisse.Insert()
    end;

    procedure TicketPlanteur()
    var
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.SetRange(TICKET, rec.TICKET);
        ItemWeighBridgecaisse.SetRange(RowID, rec.RowID);
        ItemWeighBridgecaisse.SetRange("Ticket Planteur");
        if ItemWeighBridgecaisse.FindLast() then begin
            ItemWeighBridgecaisse.EtatRegime := 'PA';
            ItemWeighBridgecaisse.EtatTransport := rec.EtatTransport;
            ItemWeighBridgecaisse."Ligne paiement" := true;
            ItemWeighBridgecaisse."Ligne paiement trans" := rec."Ligne paiement trans";
            ItemWeighBridgecaisse.Modify()
        end;
    end;

    procedure TicketTransporteur()
    var
        ItemWeighBridgecaisse: Record "Item Weigh Bridge caisse";
    begin
        ItemWeighBridgecaisse.SetRange(TICKET, rec.TICKET);
        ItemWeighBridgecaisse.SetRange(RowID, rec.RowID);
        ItemWeighBridgecaisse.SetRange("Ticket Planteur");
        if ItemWeighBridgecaisse.FindLast() then begin
            ItemWeighBridgecaisse.EtatRegime := rec.EtatRegime;
            ItemWeighBridgecaisse.EtatTransport := 'PA';
            ItemWeighBridgecaisse."Ligne paiement trans" := TRUE;
            ItemWeighBridgecaisse."Ligne paiement" := rec."Ligne paiement";
            ItemWeighBridgecaisse.Modify()
        end;

    end;

    procedure PayerTransporteur()
    var
        myInt: Integer;
    begin
        if rec."Type opération" = 'ACHAT COMPTANT' then begin
            Error('On ne peut pas payer le transporteur car ce ticket est: ACHAT COMPTANT');
        end;
        if (rec."Statut paiement" = true) then begin
            Error('Ce ticket a été déja payé pour le transporteur');
        end else begin

            rec."Statut paiement" := true;
            REC.Date_Paiement := WorkDate();

            rec.Modify();
            TransFertTicketFromItemWeigntToBridgeCaisse();
            TicketTransporteur();
            if rec."Statut paiement Planteur" = true then begin
                rec.Statut_Total_Paiement := true;
                REC.Modify()
            end;
        end;
    end;

    procedure PayerPlanteur()
    var
        myInt: Integer;
    begin
        if rec."Statut paiement Planteur" = true then begin
            Error('Ce ticket a été déja payé pour le planteur');
        end else begin
            rec."Statut paiement Planteur" := true;
            Rec.Date_Paiement := WorkDate();
            rec.Modify();
            TransFertTicketFromItemWeigntToBridgeCaisse();
            TicketPlanteur();
            if (rec."Statut paiement" = true) OR (rec."Type opération" = 'ACHAT COMPTANT') then begin
                Rec.Statut_Total_Paiement := true;
                rec.Modify();
            end;
        end;
    end;
    //FnGeek
    procedure SommeTotale()
    var
        myInt: Integer;
        PrixAchat: Record "Prix Achat";
        ParaCaisse: Record "Parametres caisse";
        VendorSplitTaxSetup: Record "Vendor Split Tax Setup";
    begin
        ParaCaisse.Reset();
        ParaCaisse.Get();
        // if REC."Statut paiement Planteur" = true then begin
        //     // Nom_Concerne := "Nom planteur";
        //     PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        //     PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
        //     PrixAchat.SetFilter("Starting Date", '<=%1', rec."Weighing 1 Date");
        //     PrixAchat.SetFilter("Ending Date", '>=%1', rec."Weighing 1 Date");
        //     PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        //     if PrixAchat.FindFirst() then begin
        //         rec.PrixUnitaire := PrixAchat."Direct Unit Cost";
        //         REC.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
        //         rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
        //         rec.TotalPlanteurTTc := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + PrixAchat."Direct Unit Cost" * rec."POIDS NET";
        //         REC.Modify();
        //         Message('yes');
        //     end;
        // end else begin
        //     if rec."Statut paiement" = true then begin
        //         // Nom_Concerne := "Driver Name";
        //         PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        //         PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
        //         PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
        //         PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
        //         PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        //         if PrixAchat.FindFirst() then begin
        //             rec.PrixUnitaire := PrixAchat."Direct Unit Cost";
        //             rec.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
        //             REC.Total := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
        //             REC.TotalTransPorteurTTC := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + (PrixAchat."Direct Unit Cost" * rec."POIDS NET");
        //             REC.Modify()
        //         end;
        //     end else
        //         if ((rec."Statut paiement" = true) and (REC."Statut paiement Planteur" = true)) then begin
        // Nom_Concerne := "Driver Name";
        PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        PrixAchat.SetFilter("Item No.", '=%1', 'TRANSPORT');
        PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
        PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
        PrixAchat.SetRange(CL, 'AY');
        PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        if PrixAchat.FindFirst() then begin
            rec.PrixUnitaireTansport := PrixAchat."Direct Unit Cost";
            // rec.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            // rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            // rec.TotalPlanteurTTc := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            REC.Total := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            REC.TotalTransPorteurTTC := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            ;
            REC.Modify()
        end;
        PrixAchat.setFilter("Purchase Type", '=%1', PrixAchat."Purchase Type"::"Vendor Posting Group");
        PrixAchat.SetFilter("Item No.", '=%1', 'RPH-9003');
        PrixAchat.SetFilter("Starting Date", '<=%1', "Weighing 1 Date");
        PrixAchat.SetFilter("Ending Date", '>=%1', "Weighing 1 Date");
        PrixAchat.SetRange(Type_Operation_Options, rec."Type opération");
        if PrixAchat.FindFirst() then begin
            VendorSplitTaxSetup.SetRange("Vendor No.", rec."Code planteur");
            if VendorSplitTaxSetup.FindFirst() then begin
                rec.PrixUnitaire := PrixAchat."Direct Unit Cost" - VendorSplitTaxSetup.Cost;
                REC.Impot := (VendorSplitTaxSetup.Percentage / 100) * PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                rec.TotalPlanteurTTc := (PrixAchat."Direct Unit Cost" * rec."POIDS NET") - (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * (VendorSplitTaxSetup.Percentage / 100));
                REC.Modify()
            end else begin
                Message('La retenue impôt du fournisseur : %1 n''est pas configuré', VendorSplitTaxSetup."Vendor No.");
                rec.PrixUnitaire := PrixAchat."Direct Unit Cost";
                REC.Impot := 0;
                rec.TotalPlanteur := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                rec.TotalPlanteurTTc := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
                REC.Modify()
            end;

            // rec.Impot := ParaCaisse.PoucentageImpot * PrixAchat."Direct Unit Cost" * rec."POIDS NET";

            // REC.Total := PrixAchat."Direct Unit Cost" * rec."POIDS NET";
            // REC.TotalTransPorteurTTC := (PrixAchat."Direct Unit Cost" * rec."POIDS NET" * ParaCaisse.PoucentageImpot) + (PrixAchat."Direct Unit Cost" * rec."POIDS NET");


        end;
        // end;

        // end;
    end;
    //FnGeek Ecriture transaction
    procedure Transactionsplanteur()
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
        Transaction.Description := rec."Ticket Planteur" + ':' + ' ' + rec."Code planteur" + ' ' + rec.ORIGINE;
        Transaction.Montant := -rec.TotalPlanteur;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Message('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := rec."Code planteur";
        Transaction.Nom := rec."Nom planteur";
        Transaction."N° Document" := rec."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := -rec.TotalPlanteurTTc;
        Transaction."Origine Operation" := rec.ORIGINE;
        Transaction.Insert()
    end;

    procedure TransactionsTransport()
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
        Transaction.Description := rec."Ticket Planteur" + ':' + ' ' + rec."Code Transporteur" + ' ' + rec.ORIGINE;
        Transaction.Montant := -rec.TotalTransport;
        Caisse.SetRange("User ID", UserId);
        if Caisse.FindFirst() then begin
            Transaction."Code caisse" := Caisse."Code caisse";
        end else begin
            Message('L''utilisateur %1 n''est pas configuré comme caissier', UserId);
        end;
        Transaction."N° Client" := rec."Code Transporteur";
        Transaction.Nom := rec."Nom Transporteur";
        Transaction."N° Document" := rec."Ticket Planteur";
        Transaction."Mode de reglement" := Format(rec.Mode_Paiement);
        Transaction."user id" := UserId;
        Transaction."validée" := true;
        Transaction."Montant NET" := -rec.TotalTransPorteurTTC;
        Transaction."Origine Operation" := rec.ORIGINE;
        Transaction.Insert()
    end;

    procedure CheckSoldePlanteur()
    var
        Transaction: Record Transactions;
        total: Decimal;
    begin
        Clear(total);
        // REC.CalcFields(TotalPlanteurTTc);
        Transaction.SetFilter("user id", '=%1', UserId);
        if Transaction.FindSet() then begin
            repeat begin
                total += Transaction."Montant NET";
            end until Transaction.Next() = 0;
            if rec.TotalPlanteurTTc > total then begin
                Error('Vous ne pouvez pas payer ce ticket de solde %1 car le solde de la caisse est %2', rec.TotalPlanteurTTc, total);
            end;
        end;
    end;

    procedure CheckSoldePTransPort()
    var
        Transaction: Record Transactions;
        total: Decimal;
    begin
        Clear(total);
        // REC.CalcFields(TotalPlanteurTTc);
        Transaction.SetFilter("user id", '=%1', UserId);
        if Transaction.FindSet() then begin
            repeat begin
                total += Transaction."Montant NET";
            end until Transaction.Next() = 0;
            if rec.TotalTransPorteurTTC > total then begin
                Error('Vous ne pouvez pas payer ce ticket de solde %1 car le solde de la caisse est %2', rec.TotalTransPorteurTTC, total);
            end;
        end;
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Clear(PaiementVisiblePlanteur);
        Clear(PaiementVisibleTransporteur);
        if rec."Statut paiement" = false then begin
            PaiementVisibleTransporteur := true;
        end;
        if rec."Statut paiement Planteur" = false then begin
            PaiementVisiblePlanteur := TRUE;
        end;
        SommeTotale();
        CurrPage.Update();

    end;

    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin
        // CurrPage.Update();
    end;

    var
        PlanterCodeunit: Codeunit "Planter's Post";
        Ticket1: Integer;
        TicketPlanteur1: Code[50];
        ROWID1: Integer;
        rowno1: Integer;
        PaiementVisiblePlanteur: Boolean;
        PaiementVisibleTransporteur: Boolean;

}