page 70112 "Paiement Ticket"
{
    ApplicationArea = All;
    Caption = 'Paiement';
    PageType = Card;
    SourceTable = "Item Weigh Bridge";
    InsertAllowed = false;
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
                }
                field("Nombre de planteurs"; Rec."Nombre de planteurs")
                {
                    ApplicationArea = All;
                    Enabled = REC.MultiPese;
                }
                field("Balance Code"; Rec."Balance Code")
                {
                    ToolTip = 'Specifies the value of the Balance Code field.', Comment = '%';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit_PointCaisse(xRec) then
                            CurrPage.Update();
                    end;
                }
                //<<Fabrice Smart 05_03_25
                field("Client/Fournisseur"; rec."Client/Fournisseur")
                {
                    ApplicationArea = All;
                }
                field("Code article"; rec."Code article")
                {
                    ApplicationArea = All;
                    TableRelation = Item;

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
                }
                field(ORIGINE; rec.ORIGINE)
                {
                    Enabled = NOT REC.MultiPese;
                    ApplicationArea = All;
                    TableRelation = Origine.Origine;
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
                    ApplicationArea = All;
                    TableRelation = "Type Vehicule"."Matricule Vehicule";
                }
                field("Vehicle Registration No."; "Vehicle Registration No.")
                {
                    ApplicationArea = All;
                }

                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Code Transporteur"; REC."Code Transporteur")
                {
                    ApplicationArea = All;
                    TableRelation = Vendor;

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
                }
                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                    // TableRelation = Vendor where("Vendor Posting Group"=const(''));
                    Enabled = not REC.MultiPese;
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
                }
                //<<Fabrice Smart 05_03_25
                field("Ticket Planteur"; Rec."Ticket Planteur")
                {
                    ToolTip = 'Specifies the value of the Ticket Planteur field.', Comment = '%';
                    ApplicationArea = All;
                    // Editable = false;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit_PointCaisse(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Item Origin"; Rec."Item Origin")
                {
                    ToolTip = 'Specifies the value of the Item Origin field.', Comment = '%';
                    Editable = false;
                }
                field(BonEnlevement; REC.BonEnlevement)
                {
                    ApplicationArea = All;
                }
                field("N° Commande PIC"; "N° Commande PIC")
                {
                    ApplicationArea = All;
                }
                field("Process Ticket"; rec."Process Ticket")
                {
                    Editable = true;
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
                field(NCNI; rec.NCNI)
                {
                    ApplicationArea = All;
                }
                field(Mode_Paiement; rec.Mode_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Observation; rec.Observation)
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Ticket: Record "Item Weigh Bridge";
                        ticket1: Integer;
                        row: Integer;
                        ticketplanteur: code[50];
                        rowid1: Integer;
                    begin
                        // Clear(ticket1);
                        // Clear(row);
                        // Clear(ticketplanteur);
                        // Clear(rowid1);
                        // ticket1 := rec.TICKET;
                        // row := rec."Row No.";
                        // ticketplanteur := rec."Ticket Planteur";
                        // rowid1 := rec.RowID;
                        // Message('a: %1 b: %2', ticket1,row);
                        PayerPlanteur();

                        // Ticket.SetRange(TICKET, ticket1);
                        // ticket.SetRange("Row No.", row);
                        // Ticket.SetRange("Ticket Planteur", ticketplanteur);
                        // ticket.SetRange(RowID, rowid1);
                        // if ticket.FindFirst() then begin
                        //     Message('ti:%1', ticket."Ticket Planteur");
                        //     // RunModal(Report::"Ticket de caisse", ticket)
                        //     Report.Run(70048, false, false, ticket);
                        // end;

                    end;

                }
                action(Paiement_Transpoteur)
                {
                    Caption = 'Payer le transporteur';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Ticket: Record "Item Weigh Bridge";
                        ticket1: Integer;
                        row: Integer;
                        ticketplanteur: code[50];
                        rowid1: Integer;
                    begin
                        // Clear(ticket1);
                        // Clear(row);
                        // Clear(ticketplanteur);
                        // Clear(rowid1);
                        // ticket1 := rec.TICKET;
                        // row := rec."Row No.";
                        // ticketplanteur := rec."Ticket Planteur";
                        // rowid1 := rec.RowID;
                        PayerTransporteur();
                        // Ticket.SetRange(TICKET, ticket1);
                        // ticket.SetRange("Row No.", row);
                        // Ticket.SetRange("Ticket Planteur", ticketplanteur);
                        // ticket.SetRange(RowID, rowid1);
                        // if ticket.FindFirst() then begin
                        //     Message('ti:%1', ticket."Ticket Planteur");
                        //     // RunModal(Report::"Ticket de caisse", ticket)
                        //     Report.Run(70048, false, false, ticket);
                        // end;
                    end;

                }
                action(Paiement_Planteur_Fournissuer)
                {
                    Caption = 'Payer le planteur & le transporteur';
                    Promoted = true;
                    PromotedCategory = Process;
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    RunObject = report Recu_Paiement;
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
        ItemWeighBridgecaisse.DateRegime := rec.DateRegime;
        ItemWeighBridgecaisse.DateTransport := rec.DateTransport;
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

    var
        PlanterCodeunit: Codeunit "Planter's Post";
}