page 70141 Creation_Ticket
{
    // PROJECT :
    // ****************************************************************************************************************************************************************
    // SIGN
    // ****************************************************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // ****************************************************************************************************************************************************************
    // VER      SIGN     DATE        UserID             DESCRIPTION
    // ****************************************************************************************************************************************************************
    // 1.47     B2B    20-Apr-15    SatishKNV           New Page is created for Item Weight Bridge Functionality related.

    CaptionML = ENU = 'Item Weight Bridge', FRA = 'Création tickets';

    Editable = false;
    DeleteAllowed = false;

    InsertAllowed = false;
    UsageCategory = Lists;
    ModifyAllowed = false;
    PageType = List;
    CardPageId = "New Ticket";
    SourceTable = "Item Weigh Bridge";
    SourceTableView = SORTING(TICKET, "Row No.")
                      ORDER(Descending) where(valide = CONST(false), TicketAnnule = const(false));
    //   WHERE("Type of Transportation" = CONST('RECEPTION'), "Type of Transportation" = const('EXPEDITION'));

    layout
    {
        area(content)
        {
            /*FnGeek commented for the moment in the future we must decomment for the news features*********15_11_25
            part("Create Payments"; "Create Payment Smart")
            {
                ApplicationArea = All;
                Visible = isCaissier;

            }
             FnGeek commented for the moment in the future we must decomment for the news features*********15_11_25*/


            repeater(Group)
            {
                // field(Selection; rec.Selection)
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }
                field(TICKET; TICKET)
                {
                    Visible = false;
                }
                field("Ticket Planteur"; "Ticket Planteur")
                {

                }
                field("Vehicle Registration No."; "Vehicle Registration No.")
                {
                    ApplicationArea = all;
                }
                field(CodeMultiPese; rec.CodeMultiPese)
                {
                    ApplicationArea = All;
                }

                field("Type opération"; "Type opération")
                {

                }
                field("Balance Code"; rec."Balance Code")
                {
                    ApplicationArea = All;
                }
                field(MultiPese; rec.MultiPese)
                {
                    ApplicationArea = All;
                }
                field(Transit; rec.Transit)
                {
                    ApplicationArea = All;
                }
                field("Process Ticket"; rec."Process Ticket")
                {
                    ApplicationArea = All;
                }
                field(ORIGINE; rec.ORIGINE)
                {
                    ApplicationArea = All;
                }
                field("Code planteur"; "Code planteur")
                {
                }
                field("Nom planteur"; "Nom planteur")
                {
                }
                field("Code Transporteur"; "Code Transporteur")
                {
                }
                field("Nom Transporteur"; "Nom Transporteur")
                {
                }

                //<<Fab Smartech 24_04_25
                field(valide; REC.valide)
                {
                    ApplicationArea = All;
                }
                field(Annule; REC.Annule)
                {
                    ApplicationArea = All;
                }
                field("Date validation"; rec."Date validation")
                {
                    ApplicationArea = All;
                }
                field("Statut paiement"; rec."Statut paiement")
                {
                    ApplicationArea = All;
                }
                field("Statut paiement Planteur"; rec."Statut paiement Planteur")
                {
                    ApplicationArea = All;
                }
                field(Statut_Total_Paiement; REC.Statut_Total_Paiement)
                {
                    ApplicationArea = All;
                }
                field("Nom Client"; "Nom Client")
                {
                    ApplicationArea = All;
                }
                //<<Fab Smartech 24_04_25
                field("POIDS ENTREE"; "POIDS ENTREE")
                {
                    Editable = false;
                    Visible = true;
                }
                field("POIDS SORTIE"; "POIDS SORTIE")
                {
                    Editable = false;
                }
                field("POIDS NET"; "POIDS NET")
                {
                    Editable = false;
                }
                field("Item Origin"; "Item Origin")
                {
                    CaptionML = FRA = 'Origine produit', ENU = 'Origin product';
                }
                field("Row No."; "Row No.")
                {
                    Visible = false;
                }
                field("Weighing 2 Date"; "Weighing 2 Date")
                {
                }
                field("Weighing 1 Date"; "Weighing 1 Date")
                {
                }
                field("Weighing 1 Hour"; "Weighing 1 Hour")
                {
                }
                field("Weighing 2 Hour"; "Weighing 2 Hour")
                {
                }
                field("Driver Name"; "Driver Name")
                {
                }
                // field("Vehicle Registration No."; "Vehicle Registration No.")
                // {
                // }
                field("Type of Transportation"; "Type of Transportation")
                {

                }
                // field("Type opération"; "Type opération")
                // {

                // }



                field("Code article"; "Code article")
                {
                }
                field("Désignation article"; "Désignation article")
                {
                }
                field("Purchase Invoice No."; "Purchase Invoice No.")
                {
                }
                field("Purchase invoice Created"; "Purchase invoice Created")
                {
                    Editable = true;
                }
                field("Purchase invoice Tcreate"; "Purchase invoice Tcreate")
                {
                    Editable = true;
                }
                field("TPurchase Invoice No."; "TPurchase Invoice No.")
                {
                }
                field(Commentaire; Commentaire)
                {
                }
                field(CommentaireT; CommentaireT)
                {
                }
                field("Traitement effectué"; "Traitement effectué")
                {
                    Editable = false;
                }
                field("Ticket annule"; "Ticket annule")
                {
                }
                field("Purchase Order Created"; "Purchase Order Created") { ApplicationArea = all; }
                field("Sales invoice Created"; "Sales invoice Created") { ApplicationArea = all; }
                field("N° Commande PIC"; "N° Commande PIC") { ApplicationArea = all; }
            }
        }

    }


    actions
    {
        area(processing)
        {
            group(Paiement)
            {
                // action(Paiement_Planteur)
                // {
                //     Caption = 'Payer le planteur';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin
                //         rec."Statut paiement Planteur" := true;
                //         rec.Modify();
                //         if rec."Statut paiement" = true then begin
                //             Rec.Statut_Total_Paiement := true;
                //             rec.Modify();
                //         end;
                //         if rec.Statut_Total_Paiement = true then begin
                //             TransFertTicketFromItemWeigntToBridgeCaisse()
                //         end;
                //     end;

                // }
                // action(Paiement_Transpoteur)
                // {
                //     Caption = 'Payer le transporteur';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin
                //         rec."Statut paiement" := true;
                //         rec.Modify();
                //         if rec."Statut paiement Planteur" = true then begin
                //             rec.Statut_Total_Paiement := true;
                //             REC.Modify()
                //         end;
                //         if rec.Statut_Total_Paiement = true then begin
                //             TransFertTicketFromItemWeigntToBridgeCaisse()
                //         end;
                //     end;

                // }
                // action(Paiement_Planteur_Fournissuer)
                // {
                //     Caption = 'Payer le planteur & le transporteur';
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin
                //         rec."Statut paiement Planteur" := true;
                //         rec."Statut paiement" := true;
                //         REC.Statut_Total_Paiement := true;
                //         rec.Modify();
                //         if rec.Statut_Total_Paiement = true then begin
                //             TransFertTicketFromItemWeigntToBridgeCaisse()
                //         end;

                //     end;

                // }
                //     action(Paiement) 
                //     {
                //         Caption = 'Payer le Transporteur';
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         ApplicationArea = All;
                //         Image = Post;
                //         Enabled = isTicketCreation;
                //         trigger OnAction()
                //         var
                //             ItemWeight: Record "Item Weigh Bridge";
                //             Payement: Codeunit Payement;
                //         begin
                //             ItemWeight.SetRange("Code planteur", rec."Code planteur");
                //             ItemWeight.SetRange(TICKET, rec.TICKET);
                //             ItemWeight.SetRange("Row No.", Rec."Row No.");
                //             // ItemWeight.SetRange("Statut paiement", true);
                //             if ItemWeight.FindFirst() then begin
                //                 PlanterCodeunit.ValidationFactureTransportLot();
                //             end else begin
                //                 Message('Vérifiez les informations du ticket');
                //             end;

                //         end;
                //     }
                //     action(PaiementPlanteur)
                //     {
                //         Caption = 'Payer le planteur';
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         ApplicationArea = All;
                //         Image = Post;
                //         Enabled = isTicketCreation;
                //         trigger OnAction()
                //         var
                //             ItemWeight: Record "Item Weigh Bridge";
                //             Payement: Codeunit Payement;
                //         begin
                //             ItemWeight.SetRange("Code planteur", rec."Code planteur");
                //             ItemWeight.SetRange(TICKET, rec.TICKET);
                //             ItemWeight.SetRange("Row No.", Rec."Row No.");
                //             // ItemWeight.SetRange("Statut paiement Planteur",true);
                //             if ItemWeight.FindFirst() then begin
                //                 PlanterCodeunit.ValidationFacturePlanteurLot();
                //             end else begin
                //                 Message('Vérifiez les informations du ticket');
                //             end;

                //         end;
                //     }
                //******Fonctionnalité d'annulation de ticket
                action(Envoie)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Caption = 'Demander une annulation';
                    Visible = FALSE;

                    trigger OnAction()
                    var
                        UserSetep: Record "User Setup";
                        UserSetep2: Record "User Setup";
                    begin

                    end;
                }
                action(AutorisationAnnulation)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = FALSE;
                    Caption = 'Autoriser l''annulation';
                    trigger OnAction()
                    begin

                    end;
                }
                action(AnnulerTicket)
                {
                    Caption = 'Aannuler le ticket';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    Visible = FALSE;
                    trigger OnAction()
                    begin

                    end;
                }
                //*****
                action(Impression)
                {
                    Caption = 'Imprimer multiple-Pesé';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetFilter(CodeMultiPese, '=%1', rec.CodeMultiPese);
                        ItemWeighBridge.SetFilter(MultiPese, '=%1', true);
                        if ItemWeighBridge.FindSet() then begin
                            Report.Run(50566, true, false, ItemWeighBridge);
                        end;
                    end;
                }
                action(Validation)
                {
                    Caption = 'Valider le ticket';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Post;
                    trigger OnAction()
                    var
                        ItemWeight2: Record "Item Weigh Bridge";
                        ticket: Record "Item Weigh Bridge";
                    begin
                        rec.TestField(valide, false);
                        rec.TestField(MultiPese, false);
                        if ((rec."POIDS SORTIE" <= 0) or (rec."POIDS ENTREE" <= 0) or ((rec."POIDS SORTIE" <= 0) and (rec."POIDS ENTREE" <= 0))) then begin
                            Error('Le ticket %1 n''est pas valide', rec."Ticket Planteur");
                        end else begin
                            rec.TestField(valide, false);
                            REC.valide := true;
                            rec."Date validation" := WorkDate();
                            rec.UserName := UserId;
                            Rec.Modify();
                            CurrPage.Update();
                            Commit();
                            // Message('Le ticket %1 créée le %2 a été validé avec succès', rec."Ticket Planteur", rec."Weighing 1 Date");//***FnGeek
                            Print();
                            rec.imprime := true;
                            REC.Modify()
                        end;

                    end;
                }

                //***FnGeek
                action(ValidationM)
                {
                    Caption = 'Valider le ticket Multi-pesé';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Image = Post;
                    trigger OnAction()
                    var
                        ItemWeight2: Record "Item Weigh Bridge";
                        ticket: Record "Item Weigh Bridge";
                        TicketMulti: Record "Item Weigh Bridge";
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        rec.TestField(MultiPese, true);
                        rec.TestField(valide, false);

                        if ((rec."POIDS SORTIE" <= 0) or (rec."POIDS ENTREE" <= 0) or ((rec."POIDS SORTIE" <= 0) and (rec."POIDS ENTREE" <= 0))) then begin
                            Error('Le ticket %1 n''est pas valide', rec."Ticket Planteur");
                        end else begin
                            rec.TestField(valide, false);
                            ItemWeighBridge.Reset();
                            ItemWeighBridge.SetRange("Ticket Planteur", Rec."Ticket Planteur");
                            ItemWeighBridge.SetRange(CodeMultiPese, rec.CodeMultiPese);
                            ItemWeighBridge.SetRange(MultiPese, true);
                            if ItemWeighBridge.FindFirst() then begin
                                Report.Run(50566, true, false, ItemWeighBridge);
                            end;

                            // TicketMulti.SetRange(CodeMultiPese, rec.CodeMultiPese);
                            // if TicketMulti.FindSet() then begin
                            //     repeat begin
                            TicketMulti.Reset();
                            TicketMulti.SetRange("Ticket Planteur", Rec."Ticket Planteur");
                            TicketMulti.SetRange(CodeMultiPese, rec.CodeMultiPese);
                            TicketMulti.SetRange(MultiPese, true);
                            if TicketMulti.FindFirst() then begin
                                TicketMulti.valide := true;
                                TicketMulti."Date validation" := WorkDate();
                                TicketMulti.UserName := UserId;
                                TicketMulti.imprime := true;
                                TicketMulti.Modify();
                            end;

                            //     TicketMulti.valide := true;
                            //     TicketMulti."Date validation" := WorkDate();
                            //     TicketMulti.UserName := UserId;
                            //     TicketMulti.imprime := true;
                            //     TicketMulti.Modify();
                            // end until TicketMulti.Next() = 0;
                            // Commit();
                            // CurrPage.Update();
                            // // Print();
                            // rec.imprime := true;
                            // REC.Modify()
                            // end;

                            // CurrPage.Update();
                            // Commit();
                            // Message('Le ticket %1 créée le %2 a été validé avec succès', rec."Ticket Planteur", rec."Weighing 1 Date");//***FnGeek
                            // Print();
                            // rec.imprime := true;
                            // REC.Modify()
                        end;
                        CurrPage.Update();
                        Message('Validation effectuée avec succès');
                        // Print();
                        // CurrPage.Update();
                    end;
                }
                //
                action(Ticket_Pont_Bascule)
                {
                    Caption = 'Ticket Pont Bascule';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        Report.Run(50500);
                    end;
                }
                action(Rapport_Quotidien)
                {
                    Caption = 'Rapport Quotidien Client Fournisseur';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        Report.Run(70049);
                    end;
                }
                action(Liste_Multi_Pesé)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Liste tickets multi-pesé';
                    RunObject = page 70142;
                }

                //     action("TicketPontBASCULE")
                //     {
                //         Caption = 'Ticket pont bascule';
                //         Image = Report;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         trigger OnAction()
                //         var
                //             ticket: Record "Item Weigh Bridge";
                //         begin
                //             Ticket.SetRange(TICKET, rec.TICKET);
                //             ticket.SetRange("Row No.", rec."Row No.");
                //             ticket.SetRange(RowID, rec.RowID);
                //             if ticket.FindFirst() then begin
                //                 // RunModal(Report::"Ticket de caisse", ticket)
                //                 Report.Run(Report::"Ticket de caisse", true, false, ticket);
                //             end;

                //         end;
                //     }
                //     action(Test)
                //     {
                //         Caption = 'Tester souche N°';
                //         ApplicationArea = All;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         trigger OnAction()
                //         var
                //             Noseries: Record "No. Series";
                //             GLSeptup: Record "General Ledger Setup";
                //             GeneralLedgerSetup: Record "General Ledger Setup";
                //             NoSeriesLine: Record "No. Series Line";
                //         begin
                //             GeneralLedgerSetup.Get();
                //             // if GeneralLedgerSetup.FIND then begin
                //             NoSeriesLine.SetRange("Series Code", GeneralLedgerSetup.NoSouche);
                //             if NoSeriesLine.FindFirst() then begin
                //                 NoSeriesLine.validate("Last No. Used", IncStr(NoSeriesLine.GetLastNoUsed()));
                //                 NoSeriesLine.Modify();
                //                 Message('N°: %1', NoSeriesLine."Last No. Used");
                //                 // Message('N: %1 N2: %2', NoSeriesLine."Ending No.",NoSeriesLine.GetLastNoUsed());
                //             end;
                //         end;
                //     }
                action("CreateNewMultiPese")
                {
                    Visible = false;
                    CaptionML = ENU = 'Create New T', FRA = 'Créer nouveau ticket Multipese';
                    Image = New;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    RunObject = page "Ticket Header";
                    // RunPageLink=

                    trigger OnAction()
                    var
                        allRec: Record "Item Weigh Bridge";
                        NewRec: Record "Item Weigh Bridge" temporary;

                        balance: Record Balance;
                        jObj: JsonObject;
                        jTok: JsonToken;
                    begin
                        // Run(PAGE::"Ticket Header");
                        // NewRec.Init();
                        // if allRec.FindLast() then
                        //     NewRec.TICKET := allRec.TICKET + 1
                        // else
                        //     NewRec.TICKET := 1;
                        // NewRec."Type of Transportation" := 'RECEPTION';
                        // NewRec."Process Ticket" := newRec."Process Ticket"::Create;
                        // NewRec.Insert(true);

                        // if page.RunModal(page::"Ticket Header", NewRec) = action::LookupOK then begin
                        //     Rec := NewRec;
                        //     Rec.Insert();
                        //     CurrPage.Update(false);
                        // end;
                        Page.Run(Page::"Ticket Header");
                    end;
                }
                action("CreateNew")
                {
                    CaptionML = ENU = 'Create New T', FRA = 'Créer nouveau ticket';
                    Image = New;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        allRec: Record "Item Weigh Bridge";
                        NewRec: Record "Item Weigh Bridge" temporary;

                        balance: Record Balance;
                        jObj: JsonObject;
                        jTok: JsonToken;
                        TicketBuffer: Integer;
                        NombrePlanteursBuffer: Integer;
                        ItemWeighBridgeMultiPese: Record "Item Weigh Bridge";
                        ControlVariable: Integer;
                        ItemWeighBridgeMultiPese2: Record "Item Weigh Bridge";
                        ItemWeighBridgeMultiPese3: Record "Item Weigh Bridge";
                    begin
                        // for ControlVariable := StartNumber to EndNumber do begin

                        // end;
                        Clear(TicketBuffer);
                        Clear(NombrePlanteursBuffer);
                        NewRec.Init();
                        if allRec.FindLast() then
                            NewRec.TICKET := allRec.TICKET + 1
                        else
                            NewRec.TICKET := 1;
                        NewRec."Type of Transportation" := 'RECEPTION';
                        NewRec."Process Ticket" := newRec."Process Ticket"::Create;
                        NewRec.Insert(true);

                        if page.RunModal(page::"New Ticket", NewRec) = action::LookupOK then begin
                            Rec := NewRec;
                            Rec.Insert();
                            TicketBuffer := REC.TICKET;
                            NombrePlanteursBuffer := rec."Nombre de planteurs";
                            CurrPage.Update(false);
                        end;
                        //<<FnGeek 05_09_25
                        ItemWeighBridgeMultiPese.SetRange(TICKET, TicketBuffer);
                        if ItemWeighBridgeMultiPese.FindFirst() then begin
                            if ItemWeighBridgeMultiPese.MultiPese = true then begin
                                for ControlVariable := 2 to ItemWeighBridgeMultiPese."Nombre de planteurs" do begin
                                    ItemWeighBridgeMultiPese2 := ItemWeighBridgeMultiPese;
                                    ItemWeighBridgeMultiPese2.TICKET += (ControlVariable - 1);
                                    ItemWeighBridgeMultiPese2."POIDS ENTREE" := 0;
                                    ItemWeighBridgeMultiPese2.Insert();
                                end;
                                ItemWeighBridgeMultiPese3.SetFilter("Ticket Planteur", ItemWeighBridgeMultiPese."Ticket Planteur");
                                if ItemWeighBridgeMultiPese3.FindSet() then begin
                                    Page.Run(page::MultiPeseSubForm, ItemWeighBridgeMultiPese3);
                                end;
                            end;
                        end;
                        //<<FnGeek 05_09_25
                    end;
                }
                //*****Multi-pesée
                action("CreateNews")
                {
                    CaptionML = ENU = 'Create New T', FRA = 'Créer Multi nouveau ticket';
                    Image = New;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        allRec: Record "Item Weigh Bridge";
                        NewRec: Record "Item Weigh Bridge" temporary;

                        balance: Record Balance;
                        jObj: JsonObject;
                        jTok: JsonToken;
                        TicketBuffer: Integer;
                        NombrePlanteursBuffer: Integer;
                        ItemWeighBridgeMultiPese: Record "Item Weigh Bridge";
                        ControlVariable: Integer;
                        ItemWeighBridgeMultiPese2: Record "Item Weigh Bridge";
                        ItemWeighBridgeMultiPese3: Record "Item Weigh Bridge";
                        NoSeriesLine: Record "No. Series Line";
                        Balances: Record Balance;
                    begin
                        // for ControlVariable := StartNumber to EndNumber do begin

                        // end;
                        Clear(TicketBuffer);
                        Clear(NombrePlanteursBuffer);
                        NewRec.Init();
                        if allRec.FindLast() then
                            NewRec.TICKET := allRec.TICKET + 1
                        else
                            NewRec.TICKET := 1;
                        NewRec."Type of Transportation" := 'RECEPTION';
                        NewRec."Process Ticket" := newRec."Process Ticket"::Create;
                        NewRec.MultiPese := true;
                        NewRec.Insert(true);
                        // if rec."Ticket Planteur" <> '' then begin

                        // end else begin

                        // end;
                        if page.RunModal(page::"New Ticket Multi Pese", NewRec) = action::LookupOK then begin
                            NewRec.TestField("Ticket Planteur");
                            Rec := NewRec;
                            Rec.Insert();
                            TicketBuffer := REC.TICKET;
                            NombrePlanteursBuffer := rec."Nombre de planteurs";
                            CurrPage.Update(false);
                        end;
                        //<<FnGeek 05_09_25
                        ItemWeighBridgeMultiPese.SetRange(TICKET, TicketBuffer);
                        if ItemWeighBridgeMultiPese.FindFirst() then begin
                            // if ItemWeighBridgeMultiPese.MultiPese = true then begin
                            for ControlVariable := 2 to ItemWeighBridgeMultiPese."Nombre de planteurs" do begin

                                ItemWeighBridgeMultiPese.TICKET += (ControlVariable - 1);
                                ItemWeighBridgeMultiPese."Ticket Planteur" := IncStr(ItemWeighBridgeMultiPese."Ticket Planteur");
                                ItemWeighBridgeMultiPese.MultiPese := true;
                                ItemWeighBridgeMultiPese."POIDS ENTREE" := 0;//Fngeek has commented
                                ItemWeighBridgeMultiPese.Insert();

                                //********FnGeek 13_02_26
                                Balances.SetRange(Code, ItemWeighBridgeMultiPese."Balance Code");
                                if Balances.FindFirst() then begin
                                    NoSeriesLine.SetRange("Series Code", Balances."Souche N°");
                                    if NoSeriesLine.FindFirst() then begin
                                        NoSeriesLine."Last No. Used" := ItemWeighBridgeMultiPese."Ticket Planteur";
                                        NoSeriesLine.Modify();
                                        // Message('aaa: %1', NoSeriesLine."Last No. Used");
                                    end;
                                end;


                                //********FnGeek
                            end;
                            ItemWeighBridgeMultiPese3.SetFilter(CodeMultiPese, ItemWeighBridgeMultiPese.CodeMultiPese);
                            if ItemWeighBridgeMultiPese3.FindSet() then begin
                                Page.Run(page::Creation_Ticket_Multipese, ItemWeighBridgeMultiPese3);
                            end;
                            // end;
                        end;
                        //<<FnGeek 05_09_25
                    end;
                }
                //**** Multi Pesée
                action("updateWeight")
                {
                    CaptionML = ENU = 'Update Out Weight', FRA = 'Enregistrer Sortie';
                    Image = OutboundEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        allRec: Record "Item Weigh Bridge";
                        NewRec: Record "Item Weigh Bridge" temporary;

                        balance: Record Balance;
                        jObj: JsonObject;
                        jTok: JsonToken;
                        //08_09_25
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        rec.TestField(MultiPese, false);
                        Rec.TestField("Process Ticket", Rec."Process Ticket"::Create);
                        NewRec.TransferFields(rec);
                        NewRec."Process Ticket" := newRec."Process Ticket"::Update;
                        NewRec.Insert(true);
                        if page.RunModal(page::"New Ticket", NewRec) = action::LookupOK then begin
                            Rec.TransferFields(NewRec);
                            Rec.Modify();
                            CurrPage.Update(false);
                        end;
                        //08_09_25 FnGeek
                        if Rec.MultiPese = true then begin
                            ItemWeighBridge.SetFilter("Ticket Planteur", '=%1', rec."Ticket Planteur");
                            if ItemWeighBridge.FindSet() then begin
                                Page.Run(page::MultiPeseSubForm, ItemWeighBridge);
                            end;
                        end;
                        //08_09_25 FnGeek
                    end;
                }
                //*****MULTI Pésé
                action("updateWeights")
                {
                    CaptionML = ENU = 'Update Out Weight', FRA = 'Enregistrer Sortie Multi-pesé';
                    Image = OutboundEntry;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        allRec: Record "Item Weigh Bridge";
                        NewRec: Record "Item Weigh Bridge" temporary;

                        balance: Record Balance;
                        jObj: JsonObject;
                        jTok: JsonToken;
                        //08_09_25
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        Rec.TestField(MultiPese, true);
                        Rec.TestField("Process Ticket", Rec."Process Ticket"::Create);
                        NewRec.TransferFields(rec);
                        NewRec."Process Ticket" := newRec."Process Ticket"::Update;
                        NewRec.Insert(true);
                        if page.RunModal(page::"New Ticket Multi Pese", NewRec) = action::LookupOK then begin
                            Rec.TransferFields(NewRec);
                            Rec.Modify();
                            CurrPage.Update(false);
                        end;
                        //08_09_25 FnGeek
                        if Rec.MultiPese = true then begin
                            ItemWeighBridge.SetFilter(CodeMultiPese, '=%1', rec.CodeMultiPese);
                            if ItemWeighBridge.FindSet() then begin
                                Page.Run(page::Creation_Ticket_Multipese, ItemWeighBridge);
                            end;
                        end;
                        //08_09_25 FnGeek
                    end;
                }

            }
        }
    }

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        // if ((USERID <> 'DEKEL\ADMINISTRATEUR')) then
        //     ERROR('Vous n''etes pas autorisé à effectuer cette action');
        UserSetup.RESET;
        if UserSetup.GET(USERID) then
            if not (UserSetup."Administration ticket") then
                ERROR('Vous n''êtes pas autorsé à éffectuer cette action');
    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        // if ((USERID <> 'DEKEL\ADMINISTRATEUR')) then
        //     ERROR('Vous n''etes pas autorisé à effectuer cette action');
        UserSetup.RESET;
        if UserSetup.GET(USERID) then
            if not (UserSetup."Administration ticket") then
                ERROR('Vous n''êtes pas autorsé à éffectuer cette action');
    end;

    trigger OnOpenPage()
    var
        UserSetep: Record "User Setup";
        UserSetep2: Record "User Setup";
        MagasinCentreLogistique: Record MagasinCentreLogistique;
    begin
        UserSetep2.SetRange("User ID", UserId);
        if UserSetep2.FindFirst() then begin
            MagasinCentreLogistique.SetRange(Prefixe, UserSetep2.CL);
            if MagasinCentreLogistique.FindFirst() then begin
                SetFilter(ORIGINE, '=%1', MagasinCentreLogistique.Description);
            end;

        end;


        AnnuleFacture := FALSE;
        UserSetup2.RESET;
        IF UserSetup2.GET(USERID) THEN BEGIN
            IF NOT (UserSetup2."Administration ticket") THEN BEGIN
                AnnuleFacture := FALSE;
            END ELSE BEGIN
                AnnuleFacture := TRUE;
            END;

            // désactiver une l'action "Payer le ticket" si le profil est Création ticket
            if UserPersonalization.Get(UserSecurityId()) then begin
                if UserPersonalization."Profile ID" = 'CRÉATION TICKET' then begin
                    isTicketCreation := false;
                end else begin
                    isTicketCreation := true;
                end;
            end;
            //désactiver la page création paiement smart si le profil n'est pas caisser
            if UserPersonalization.Get(UserSecurityId()) then begin
                if UserPersonalization."Profile ID" = 'CAISSE' then begin
                    isCaissier := true;
                end else begin
                    isCaissier := false;
                end;
            end;
        END;

        ///carelle
        Fournisseurs.RESET;
        Fournisseurs.SETRANGE("Transporteur dekel", TRUE);
        IF Fournisseurs.FINDFIRST THEN
            REPEAT
            BEGIN
                // MESSAGE('hello %1',Fournisseurs."No.");
                Tickets.RESET;
                Tickets.SETRANGE("Code Transporteur", Fournisseurs."No.");
                Tickets.SETRANGE("Transporteur dekel", FALSE);
                IF Tickets.FINDFIRST THEN
                    REPEAT
                    BEGIN
                        // Tickets."Transporteur dekel":=Fournisseurs."Transporteur dekel";
                        Tickets."Transporteur dekel" := TRUE;
                        // MESSAGE('hello2');
                        Tickets.MODIFY;
                    END;
                    UNTIL Tickets.NEXT = 0;
            END;
            UNTIL Fournisseurs.NEXT = 0;
        ///carelle,,,
        //***************


    end;

    var
        PlanterCodeunit: Codeunit "Planter's Post";
        factcr: Record "Item Weigh Bridge";
        "Ecriture Line": Record "Ecriture comptable  Ligne";
        Recap: Record "Item Weigh Bridge";
        Line: Integer;
        ProfitNet: Decimal;
        parcelle: Record Parcelle;
        RecapTemp: Record "Item Weigh Bridge";
        Startdate: Date;
        MAJ: Boolean;
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        OpenedFromBatch: Boolean;
        UserRec: Record User;
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        GenJnlTem: Record "Gen. Journal Template";
        CheckDate: Date;
        AccPeriodGRec: Record "Accounting Period";
        GenJnlBatch: Record "Item Journal Batch";
        Text000: Label 'You cannot use entry type %1 in this journal.';
        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';
        Text010: Label 'You dont have permissionto post item journal';
        Text004: Label 'Accounting Period is closed.';
        Text003: Label 'Accounting Period is not created.';
        Text0020: Label 'You dont have permission in Item journal.';
        Text0001: Label 'Traitement    #1';

        ////***

        UserSetup2: Record "User Setup";
        AnnuleFacture: Boolean;
        Fournisseurs: Record Vendor;
        Tickets: Record "Item Weigh Bridge";

        //Champs pour désactiver une l'action "Payer le ticket" si le profil est Création ticket
        isTicketCreation: Boolean;
        AllProfile: Record "All Profile";
        UserPersonalization: Record "User Personalization";
        CurrentUser: Code[50];
        isCaissier: Boolean;

    [Scope('Internal')]
    procedure CheckPostingDate("Posting Date": Date)
    begin
        AccPeriodGRec.RESET;
        AccPeriodGRec.SETFILTER(Closed, '%1', false);
        if AccPeriodGRec.FINDFIRST then
            if AccPeriodGRec."Starting Date" > "Posting Date" then
                ERROR(Text004);

        AccPeriodGRec.RESET;
        AccPeriodGRec.SETFILTER("Starting Date", '>=%1', "Posting Date");
        if not AccPeriodGRec.FINDFIRST then
            ERROR(Text003)
    end;

    [Scope('Internal')]
    procedure CheckAdminTicket()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.RESET;
        if UserSetup.GET(USERID) then
            if not (UserSetup."Administration ticket") then
                ERROR('Vous n''êtes pas autorsé à éffectuer cette action');
    end;

    // trigger
    //FnGeek**** Transfert de ticket dans la tableItem Weigh Bridge caisse "Item Weigh Bridge caisse" (Recap Paiement)**************
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
        ItemWeighBridgecaisse."Row No." := rec."Row No.";
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
        ItemWeighBridgecaisse.EtatTransport := rec.EtatTransport;
        ItemWeighBridgecaisse.EtatRegime := rec.EtatRegime;
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
        ItemWeighBridgecaisse."Ligne paiement" := rec."Ligne paiement";
        ItemWeighBridgecaisse."Traitement effectué" := rec."Traitement effectué";
        ItemWeighBridgecaisse.Commentaire := rec.Commentaire;
        ItemWeighBridgecaisse.ValautoDateTime := rec.ValautoDateTime;
        ItemWeighBridgecaisse.CommentaireT := rec.CommentaireT;
        ItemWeighBridgecaisse."Ligne paiement trans" := rec."Ligne paiement trans";
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
        ItemWeighBridgecaisse.Insert()
    end;

    procedure Print()
    var
        myInt: Integer;
        ticket: Record "Item Weigh Bridge";
    begin
        ticket.Reset();
        Ticket.SetRange(TICKET, rec.TICKET);
        ticket.SetRange("Row No.", rec."Row No.");
        ticket.SetRange("Ticket Planteur", rec."Ticket Planteur");
        ticket.SetRange(RowID, rec.RowID);
        if ticket.FindFirst() then begin
            // RunModal(Report::"Ticket de caisse", ticket)
            Report.Run(50500, true, false, ticket);
        end;


    end;
}

