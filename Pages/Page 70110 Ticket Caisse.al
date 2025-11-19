page 70110 "Ticket Caisse"
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

    CaptionML = ENU = 'Item Weight Bridge', FRA = 'Tickets Caisse';
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    CardPageId = "New Ticket";
    SourceTable = "Item Weigh Bridge";
    SourceTableView = SORTING(TICKET, "Row No.")
                      ORDER(Descending)
                      WHERE("Type of Transportation" = CONST('=RECEPTION'));

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
                }
                field("Code Transporteur"; "Code Transporteur")
                {
                }
                field("Nom Transporteur"; "Nom Transporteur")
                {
                }
                field("Ticket Planteur"; "Ticket Planteur")
                {

                }
                //<<Fab Smartech 24_04_25
                field(valide; REC.valide)
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
                //<<Fab Smartech 24_04_25
                field("POIDS ENTREE"; "POIDS ENTREE")
                {
                    Editable = true;
                    Visible = true;
                }
                field("POIDS SORTIE"; "POIDS SORTIE")
                {
                }
                field("POIDS NET"; "POIDS NET")
                {
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
                field("Vehicle Registration No."; "Vehicle Registration No.")
                {
                }
                field("Type of Transportation"; "Type of Transportation")
                {

                }
                field("Type opération"; "Type opération")
                {
                }
                field("Code planteur"; "Code planteur")
                {
                }
                field("Nom planteur"; "Nom planteur")
                {
                }


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
                action(Paiement_Planteur)
                {
                    Caption = 'Payer le planteur';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PayerPlanteur();
                    end;

                }
                action(Paiement_Transpoteur)
                {
                    Caption = 'Payer le transporteur';
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        PayerTransporteur();
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

                    // trigger OnAction()
                    // begin
                    //     rec."Statut paiement Planteur" := true;
                    //     rec."Statut paiement" := true;
                    //     REC.Statut_Total_Paiement := true;
                    //     rec.Modify();
                    //     if rec.Statut_Total_Paiement = true then begin
                    //         TransFertTicketFromItemWeigntToBridgeCaisse()
                    //     end;

                    // end;

                }

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
                //     action(Validation)
                //     {
                //         Caption = 'Valider le ticket';
                //         ApplicationArea = All;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         Image = Post;
                //         trigger OnAction()
                //         var
                //             ItemWeight2: Record "Item Weigh Bridge";
                //             ticket: Record "Item Weigh Bridge";
                //         begin
                //             REC.valide := true;
                //             rec."Date validation" := WorkDate();
                //             Rec.Modify();
                //             // Message('Le ticket %1 créée le %2 a été validé avec succès', rec."Ticket Planteur", rec."Weighing 1 Date");//***FnGeek
                //             Ticket.SetRange(TICKET, rec.TICKET);
                //             ticket.SetRange("Row No.", rec."Row No.");
                //             ticket.SetRange(RowID, rec.RowID);
                //             if ticket.FindFirst() then begin
                //                 // RunModal(Report::"Ticket de caisse", ticket)
                //                 Report.Run(Report::"Ticket de caisse", false, true, ticket);
                //             end;

                //         end;
                //     }
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
                //     action("CreateNewMultiPese")
                //     {
                //         Visible = false;
                //         CaptionML = ENU = 'Create New T', FRA = 'Créer nouveau ticket Multipese';
                //         Image = New;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         RunObject = page "Ticket Header";
                //         // RunPageLink=

                //         trigger OnAction()
                //         var
                //             allRec: Record "Item Weigh Bridge";
                //             NewRec: Record "Item Weigh Bridge" temporary;

                //             balance: Record Balance;
                //             jObj: JsonObject;
                //             jTok: JsonToken;
                //         begin
                //             // Run(PAGE::"Ticket Header");
                //             // NewRec.Init();
                //             // if allRec.FindLast() then
                //             //     NewRec.TICKET := allRec.TICKET + 1
                //             // else
                //             //     NewRec.TICKET := 1;
                //             // NewRec."Type of Transportation" := 'RECEPTION';
                //             // NewRec."Process Ticket" := newRec."Process Ticket"::Create;
                //             // NewRec.Insert(true);

                //             // if page.RunModal(page::"Ticket Header", NewRec) = action::LookupOK then begin
                //             //     Rec := NewRec;
                //             //     Rec.Insert();
                //             //     CurrPage.Update(false);
                //             // end;
                //             Page.Run(Page::"Ticket Header");
                //         end;
                //     }
                //     action("CreateNew")
                //     {
                //         CaptionML = ENU = 'Create New T', FRA = 'Créer nouveau ticket';
                //         Image = New;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         trigger OnAction()
                //         var
                //             allRec: Record "Item Weigh Bridge";
                //             NewRec: Record "Item Weigh Bridge" temporary;

                //             balance: Record Balance;
                //             jObj: JsonObject;
                //             jTok: JsonToken;
                //             TicketBuffer: Integer;
                //             NombrePlanteursBuffer: Integer;
                //             ItemWeighBridgeMultiPese: Record "Item Weigh Bridge";
                //             ControlVariable: Integer;
                //             ItemWeighBridgeMultiPese2: Record "Item Weigh Bridge";
                //             ItemWeighBridgeMultiPese3: Record "Item Weigh Bridge";
                //         begin
                //             // for ControlVariable := StartNumber to EndNumber do begin

                //             // end;
                //             Clear(TicketBuffer);
                //             Clear(NombrePlanteursBuffer);
                //             NewRec.Init();
                //             if allRec.FindLast() then
                //                 NewRec.TICKET := allRec.TICKET + 1
                //             else
                //                 NewRec.TICKET := 1;
                //             NewRec."Type of Transportation" := 'RECEPTION';
                //             NewRec."Process Ticket" := newRec."Process Ticket"::Create;
                //             NewRec.Insert(true);

                //             if page.RunModal(page::"New Ticket", NewRec) = action::LookupOK then begin
                //                 Rec := NewRec;
                //                 Rec.Insert();
                //                 TicketBuffer := REC.TICKET;
                //                 NombrePlanteursBuffer := rec."Nombre de planteurs";
                //                 CurrPage.Update(false);
                //             end;
                //             //<<FnGeek 05_09_25
                //             ItemWeighBridgeMultiPese.SetRange(TICKET, TicketBuffer);
                //             if ItemWeighBridgeMultiPese.FindFirst() then begin
                //                 if ItemWeighBridgeMultiPese.MultiPese = true then begin
                //                     for ControlVariable := 2 to ItemWeighBridgeMultiPese."Nombre de planteurs" do begin
                //                         ItemWeighBridgeMultiPese2 := ItemWeighBridgeMultiPese;
                //                         ItemWeighBridgeMultiPese2.TICKET += (ControlVariable - 1);
                //                         ItemWeighBridgeMultiPese2."POIDS ENTREE" := 0;
                //                         ItemWeighBridgeMultiPese2.Insert();
                //                     end;
                //                     ItemWeighBridgeMultiPese3.SetFilter("Ticket Planteur", ItemWeighBridgeMultiPese."Ticket Planteur");
                //                     if ItemWeighBridgeMultiPese3.FindSet() then begin
                //                         Page.Run(page::MultiPeseSubForm, ItemWeighBridgeMultiPese3);
                //                     end;
                //                 end;
                //             end;
                //             //<<FnGeek 05_09_25
                //         end;
                //     }
                //     action("updateWeight")
                //     {
                //         CaptionML = ENU = 'Update Out Weight', FRA = 'Enregistrer Sortie';
                //         Image = OutboundEntry;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         trigger OnAction()
                //         var
                //             allRec: Record "Item Weigh Bridge";
                //             NewRec: Record "Item Weigh Bridge" temporary;

                //             balance: Record Balance;
                //             jObj: JsonObject;
                //             jTok: JsonToken;
                //             //08_09_25
                //             ItemWeighBridge: Record "Item Weigh Bridge";
                //         begin
                //             Rec.TestField("Process Ticket", Rec."Process Ticket"::Create);
                //             NewRec.TransferFields(rec);
                //             NewRec."Process Ticket" := newRec."Process Ticket"::Update;
                //             NewRec.Insert(true);
                //             if page.RunModal(page::"New Ticket", NewRec) = action::LookupOK then begin
                //                 Rec.TransferFields(NewRec);
                //                 Rec.Modify();
                //                 CurrPage.Update(false);
                //             end;
                //             //08_09_25 FnGeek
                //             if Rec.MultiPese = true then begin
                //                 ItemWeighBridge.SetFilter("Ticket Planteur", '=%1', rec."Ticket Planteur");
                //                 if ItemWeighBridge.FindSet() then begin
                //                     Page.Run(page::MultiPeseSubForm, ItemWeighBridge);
                //                 end;
                //             end;
                //             //08_09_25 FnGeek
                //         end;
                //     }
                // }
                // group(ActionGroup1102152013)
                // {
                //     action("Create PurchaseInvoice")
                //     {
                //         CaptionML = ENU = 'Create Purchase Invoice', FRA = 'Créer facture achat';
                //         Image = Invoice;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         trigger OnAction()
                //         begin
                //             TESTFIELD("Purchase invoice Created", false);
                //             TESTFIELD("Ticket annule", false);
                //             CLEAR(PlanterCodeunit);
                //             PlanterCodeunit.CreateItemWgtInvoice(Rec);
                //         end;
                //     }
                //     action("Create TransportInvoice")
                //     {
                //         CaptionML = ENU = 'Create Transport Invoice', FRA = 'Créer facture transport';
                //         Image = Invoice;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         trigger OnAction()
                //         begin
                //             TESTFIELD("Purchase invoice Tcreate", false);
                //             TESTFIELD("Ticket annule", false);
                //             TestField("Transporteur dekel", false);//<<Fabrice Smart 24_02_25
                //             CLEAR(PlanterCodeunit);
                //             PlanterCodeunit.CreateTranspWgtInvoice(Rec);
                //         end;
                //     }
                //     action("Create InvoiceLot1")
                //     {
                //         CaptionML = ENU = 'Create Invoice by Lot', FRA = 'Créer facture achat régime par lot';
                //         Image = Invoice;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         Visible = false;

                //         trigger OnAction()
                //         var
                //             ItemWei: Record "Item Weigh Bridge";
                //         begin
                //             TESTFIELD("Purchase invoice Created", false);
                //             CLEAR(PlanterCodeunit);
                //             ItemWei.RESET;
                //             CurrPage.SETSELECTIONFILTER(ItemWei);

                //             PlanterCodeunit.CreateItemWgtInvoiceLot(ItemWei);
                //         end;
                //     }
                //     action("Create InvoiceLot2")
                //     {
                //         CaptionML = ENU = 'Create Invoice by Lot', FRA = 'Créer facture achat transport par lot';
                //         Image = Invoice;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         Visible = false;

                //         trigger OnAction()
                //         var
                //             ItemWei: Record "Item Weigh Bridge";
                //         begin
                //             TESTFIELD("Purchase invoice Tcreate", false);
                //             CLEAR(PlanterCodeunit);
                //             ItemWei.RESET;
                //             CurrPage.SETSELECTIONFILTER(ItemWei);
                //             PlanterCodeunit.CreateItemWgtTransportLot(ItemWei);

                //             //CreateTranspWgtInvoicelot(ItemWei);
                //         end;
                //     }
                //     action("MajTicketOrigine")
                //     {
                //         CaptionML = FRA = 'Mettre à jour l''origine d''un ticket', ENU = 'Update the origin of a ticket';
                //         Image = UpdateShipment;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         ToolTip = 'Bouton qui permet de mettre à jour l''origine d''un ticket non facturé';

                //         trigger OnAction()
                //         var
                //             ChangeOrigin: Report "Origin ticket Update";
                //         begin
                //             ChangeOrigin.SetItemWeigh(Rec);
                //             ChangeOrigin.RUNMODAL;
                //             CurrPage.UPDATE;
                //         end;
                //     }
                // }
                // group("Validation automatique")
                // {
                //     CaptionML = FRA = 'Validation automatique', ENU = 'Automatic validation';
                //     action(ValidationLotR)
                //     {
                //         CaptionML = ENU = 'Generate and post invoice', FRA = 'Generation et validation des factures regime';
                //         Image = PostBatch;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;

                //         trigger OnAction()
                //         var
                //             ItemWei: Record "Item Weigh Bridge";
                //         begin
                //             // PlanterCodeunit.ValidationFacturePlanteurLot;
                //         end;
                //     }
                //     action(ValidationLotT)
                //     {
                //         CaptionML = ENU = 'Generate and post invoice transport', FRA = 'Generation et validation des factures transport';
                //         Image = PostedServiceOrder;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         Visible = false;

                //         trigger OnAction()
                //         var
                //             ItemWei: Record "Item Weigh Bridge";
                //         begin
                //             // CurrPage.SetSelectionFilter(ItemWei);
                //             PlanterCodeunit.ValidationFactureTransportLot();

                //         end;
                //     }
                //     action("Validation des tickets")
                //     {
                //         CaptionML = FRA = 'Validation des tickets', ENU = 'Ticket validation';
                //         Image = AutofillQtyToHandle;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = Codeunit "Planter's Post";
                //     }
                // }
                // group(Documents)
                // {
                //     Caption = 'Documents';
                //     Image = Documents;
                //     action(Invoice)
                //     {
                //         CaptionML = ENU = 'Purchase Invoice', FRA = 'Factures achats régime';
                //         Image = PostDocument;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = page "factures achats";
                //         //RunPageLink = "No." = FIELD("Purchase Invoice No.");
                //         RunPageView = WHERE("Buy-from Vendor No." = CONST('FAG*'));
                //     }
                //     action(Action1000000016)
                //     {
                //         CaptionML = ENU = 'Transport Purchase Invoice', FRA = 'Factures achats transport';
                //         Image = PostDocument;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = page "factures achats";
                //         //RunPageLink = "No." = FIELD("TPurchase Invoice No.");
                //         RunPageView = WHERE("Buy-from Vendor No." = CONST('FTR*'));
                //     }
                // }
                // group(Administration)
                // {
                //     Caption = 'Administration';
                //     action("MAJ code transport")
                //     {
                //         CaptionML = ENU = 'Update transport code', FRA = 'MAJ code transport';
                //         Image = UpdateXML;
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             tempTick: Record "Temp ticket";
                //             ItemW: Record "Item Weigh Bridge";
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //                               //factcr.RESET;
                //                               //factcr.SETRANGE("Purchase invoice Created",FALSE);
                //                               // factcr.MODIFYALL(factcr."Purchase invoice Created",TRUE);
                //                               //Mise à jour du ticket à partir de la table 50143
                //             MESSAGE('Debut');
                //             tempTick.RESET;
                //             if tempTick.FINDFIRST then
                //                 repeat
                //                     ItemW.RESET;
                //                     if ItemW.GET(tempTick.TICKET, tempTick."Row No.", tempTick.RowID) then begin

                //                         ItemW."Code Transporteur" := tempTick."Code Transporteur";
                //                         ItemW.MODIFY;


                //                     end;



                //                 until tempTick.NEXT = 0;

                //             MESSAGE('Opération terminée');
                //         end;
                //     }
                //     action("Flush Facture Ticket")
                //     {
                //         CaptionML = ENU = 'Flush Facture Ticket', FRA = 'Flush Invoice Ticket';
                //         Image = DeleteAllBreakpoints;
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             GL: Record "G/L Entry";
                //             VAT: Record "VAT Entry";
                //             FD: Record "Detailed Vendor Ledg. Entry";
                //             Four: Record "Vendor Ledger Entry";
                //             Valeur: Record "Value Entry";
                //             FAE: Record "Purch. Inv. Header";
                //             FAL: Record "Purch. Inv. Line";
                //             Dossier: Code[10];
                //             Tick: Record TIKECT;
                //             MyDialog: Dialog;
                //             TempFAE: Record "Purch. Inv. Header";
                //             ItemW: Record "Item Weigh Bridge";
                //             FAETemp: Record "Purch. Inv. Header";
                //         begin

                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //                               // vérification du droit Administrateur des tickets
                //                               //CheckAdminTicket; // vérification du droit Administrateur des ticketsSuppression par table 50031 N° Ticket

                //             if not CONFIRM('Action a risque voulez-vous continez?', true) then exit;

                //             //Cas des facture comptabilisé
                //             //    Traitement des tickets planteurs
                //             MyDialog.OPEN(Text0001, FAE."No.");
                //             Tick.RESET;
                //             if Tick.FINDFIRST then
                //                 repeat

                //                     CLEAR(Dossier);

                //                     Dossier := Tick.code;

                //                     FAL.LOCKTABLE(true);
                //                     GL.LOCKTABLE(true);
                //                     VAT.LOCKTABLE(true);
                //                     Four.LOCKTABLE(true);
                //                     Valeur.LOCKTABLE(true);
                //                     FD.LOCKTABLE(true);
                //                     FAL.LOCKTABLE(true);
                //                     FAE.LOCKTABLE(true);

                //                     FAE.RESET;
                //                     FAE.SETRANGE(FAE."Folder No.", Dossier);   //Par numero de dossier
                //                                                                //FAE.SETRANGE(FAE."Posting Date",011122D,091122D);  //Par plage de date
                //                     FAE.SETFILTER(FAE."Buy-from Vendor No.", '%1', 'FAG*');
                //                     if FAE.FINDFIRST then
                //                         repeat
                //                             MyDialog.UPDATE();

                //                             GL.RESET;
                //                             GL.SETRANGE(GL."Document No.", FAE."No.");
                //                             if GL.FINDFIRST then
                //                                 GL.DELETEALL;

                //                             VAT.RESET;
                //                             VAT.SETRANGE(VAT."Document No.", FAE."No.");
                //                             if VAT.FINDFIRST then
                //                                 VAT.DELETEALL;

                //                             FD.RESET;
                //                             FD.SETRANGE(FD."Document No.", FAE."No.");
                //                             if FD.FINDFIRST then
                //                                 FD.DELETEALL;


                //                             Four.RESET;
                //                             Four.SETRANGE(Four."Document No.", FAE."No.");
                //                             if Four.FINDFIRST then
                //                                 Four.DELETEALL;


                //                             Valeur.RESET;
                //                             Valeur.SETRANGE(Valeur."Document No.", FAE."No.");
                //                             if Valeur.FINDFIRST then
                //                                 Valeur.DELETEALL;


                //                             FAL.RESET;
                //                             FAL.SETRANGE(FAL."Document No.", FAE."No.");
                //                             if FAL.FINDFIRST then
                //                                 FAL.DELETEALL;

                //                             //Desactivation des lignes ticket
                //                             ItemW.RESET;
                //                             ItemW.SETRANGE(ItemW."Ticket Planteur", FAE."Folder No.");
                //                             if ItemW.FINDFIRST then begin
                //                                 ItemW."Purchase invoice Created" := false;
                //                                 ItemW."Purchase Invoice No." := '';

                //                                 ItemW.MODIFY;

                //                             end;

                //                             FAETemp.RESET;
                //                             if FAETemp.GET(FAE."No.") then
                //                                 FAETemp.DELETE;


                //                         //FAE.DELETE;

                //                         until FAE.NEXT = 0;


                //                 until Tick.NEXT = 0;
                //             MyDialog.CLOSE();
                //             MESSAGE('Opération terminée');


                //             // Traitement des tickets transport

                //             CLEAR(Dossier);
                //             MyDialog.OPEN(Text0001, Dossier);
                //             //Dossier:=Tick.code;
                //             MyDialog.UPDATE();
                //             FAE.RESET;
                //             FAE.SETRANGE(FAE."Folder No.", Dossier);
                //             //FAE.SETRANGE(FAE."Posting Date",011122D,091122D);  //Par plage de date
                //             FAE.SETFILTER(FAE."Buy-from Vendor No.", '%1', 'FTR*');
                //             if FAE.FINDFIRST then
                //                 repeat
                //                     Dossier := FAE."Folder No.";
                //                     MyDialog.UPDATE();


                //                     GL.RESET;
                //                     GL.SETRANGE(GL."Document No.", FAE."No.");
                //                     if GL.FINDFIRST then
                //                         GL.DELETEALL;

                //                     VAT.RESET;
                //                     VAT.SETRANGE(VAT."Document No.", FAE."No.");
                //                     if VAT.FINDFIRST then
                //                         VAT.DELETEALL;

                //                     FD.RESET;
                //                     FD.SETRANGE(FD."Document No.", FAE."No.");
                //                     if FD.FINDFIRST then
                //                         FD.DELETEALL;

                //                     Four.RESET;
                //                     Four.SETRANGE(Four."Document No.", FAE."No.");
                //                     if Four.FINDFIRST then
                //                         Four.DELETEALL;

                //                     Valeur.RESET;
                //                     Valeur.SETRANGE(Valeur."Document No.", FAE."No.");
                //                     if Valeur.FINDFIRST then
                //                         Valeur.DELETEALL;

                //                     FAL.RESET;
                //                     FAL.SETRANGE(FAL."Document No.", FAE."No.");
                //                     if FAL.FINDFIRST then
                //                         FAL.DELETEALL;

                //                     //Desactivation des lignes ticket
                //                     ItemW.RESET;
                //                     ItemW.SETRANGE(ItemW."Ticket Planteur", FAE."Folder No.");
                //                     if ItemW.FINDFIRST then begin
                //                         ItemW."Purchase invoice Tcreate" := false;
                //                         ItemW."TPurchase Invoice No." := '';
                //                         ItemW.MODIFY;

                //                     end;

                //                     TempFAE.RESET;
                //                     TempFAE.GET(FAE."No.");
                //                     TempFAE.DELETE;

                //                 until FAE.NEXT = 0;
                //             MyDialog.CLOSE();
                //             MESSAGE('Opération terminée');
                //         end;
                //     }
                //     action("Flush Avoir transport")
                //     {
                //         CaptionML = ENU = 'Flush Avoir transport', FRA = 'Flush Avoir transport';
                //         Image = DeleteQtyToHandle;
                //         Visible = false;

                //         trigger OnAction()
                //         var
                //             GL: Record "G/L Entry";
                //             VAT: Record "VAT Entry";
                //             FD: Record "Detailed Vendor Ledg. Entry";
                //             Four: Record "Vendor Ledger Entry";
                //             Valeur: Record "Value Entry";
                //             FAE: Record "Purch. Cr. Memo Hdr.";
                //             FAL: Record "Purch. Cr. Memo Line";
                //             Dossier: Code[10];
                //             Tick: Record TIKECT;
                //             MyDialog: Dialog;
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //             MyDialog.OPEN(Text0001, Dossier);
                //             Tick.RESET;
                //             if Tick.FINDFIRST then
                //                 repeat

                //                     CLEAR(Dossier);

                //                     Dossier := Tick.code;
                //                     MyDialog.UPDATE();
                //                     FAE.RESET;
                //                     FAE.SETRANGE(FAE."No.", Dossier);
                //                     FAE.SETFILTER(FAE."Buy-from Vendor No.", '%1', 'FTR*');
                //                     if FAE.FINDFIRST then begin

                //                         GL.RESET;
                //                         GL.SETRANGE(GL."Document No.", FAE."No.");
                //                         if GL.FINDFIRST then
                //                             GL.DELETEALL;

                //                         VAT.RESET;
                //                         VAT.SETRANGE(VAT."Document No.", FAE."No.");
                //                         if VAT.FINDFIRST then
                //                             VAT.DELETEALL;

                //                         FD.RESET;
                //                         FD.SETRANGE(FD."Document No.", FAE."No.");
                //                         if FD.FINDFIRST then
                //                             FD.DELETEALL;

                //                         Four.RESET;
                //                         Four.SETRANGE(Four."Document No.", FAE."No.");
                //                         if Four.FINDFIRST then
                //                             Four.DELETEALL;

                //                         Valeur.RESET;
                //                         Valeur.SETRANGE(Valeur."Document No.", FAE."No.");
                //                         if Valeur.FINDFIRST then
                //                             Valeur.DELETEALL;

                //                         FAL.RESET;
                //                         FAL.SETRANGE(FAL."Document No.", FAE."No.");
                //                         if FAL.FINDFIRST then
                //                             FAL.DELETEALL;


                //                         FAE.DELETE;







                //                     end;
                //                 until Tick.NEXT = 0;
                //             MyDialog.CLOSE();
                //             MESSAGE('Opération terminée');
                //         end;
                //     }
                //     action("Rechercher les doublons")
                //     {
                //         CaptionML = ENU = 'Check for duplicates', FRA = 'Rechercher les doublons';
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             Ticket: Record "Item Weigh Bridge";
                //             Ticketemp: Record "Item Weigh Bridge";
                //             Windows: Dialog;
                //             Text1: Label 'Counting  #1';
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //             Ticket.RESET;
                //             Ticket.SETCURRENTKEY(RowID);
                //             Ticket.SETRANGE("Weighing 1 Date", 20220201D, 20220228D);
                //             Ticket.SETRANGE(Doublon, false);
                //             Windows.OPEN(Text1, Ticket.RowID);
                //             if Ticket.FINDFIRST then
                //                 repeat
                //                     Windows.UPDATE;
                //                     Ticketemp.RESET;
                //                     Ticketemp.SETCURRENTKEY(RowID);
                //                     Ticketemp.SETRANGE(Ticketemp."Ticket Planteur", Ticket."Ticket Planteur");
                //                     Ticketemp.SETFILTER(Ticketemp.RowID, '<>%1', Ticket.RowID);
                //                     if Ticketemp.FINDFIRST then
                //                         repeat
                //                             Ticketemp.Doublon := true;
                //                             Ticketemp.MODIFY;
                //                         until Ticketemp.NEXT = 0;
                //                 until Ticket.NEXT = 0;
                //             Windows.CLOSE;
                //         end;
                //     }
                //     action("Supprimer les doublons")
                //     {
                //         CaptionML = FRA = 'Supprimer les doublons', ENU = 'Remove duplicates';
                //         Visible = false;

                //         trigger OnAction()
                //         var
                //             Ticket: Record "Item Weigh Bridge";
                //             Ticketemp: Record "Item Weigh Bridge";
                //             Windows: Dialog;
                //             Text1: Label 'Counting  #1';
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //             Ticket.RESET;
                //             Ticket.SETRANGE("Weighing 1 Date", 20220101D, 20220131D);
                //             Ticket.SETRANGE(Doublon, true);
                //             if Ticket.FINDFIRST then
                //                 Ticket.DELETEALL;
                //         end;
                //     }
                //     action(Reset)
                //     {
                //         Caption = 'Reset';
                //         Visible = true;

                //         trigger OnAction()
                //         var
                //             Ticket: Record "Item Weigh Bridge";
                //             Ticketemp: Record "Item Weigh Bridge";
                //             Windows: Dialog;
                //             Text1: Label 'Traitement    #1';
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets
                //             Ticket.RESET;
                //             Ticket.SETRANGE("Weighing 1 Date", 20220101D, 20220131D);
                //             Ticket.SETRANGE("Type of Transportation", 'RECEPTION');
                //             Ticket.SETFILTER("Type opération", '<>%1', 'PI');
                //             Windows.OPEN(Text1, Ticket.RowID);
                //             if Ticket.FINDFIRST then
                //                 repeat
                //                     Windows.UPDATE;
                //                     Ticketemp.RESET;
                //                     if Ticketemp.GET(Ticket.TICKET, Ticket."Row No.", Ticket.RowID) then begin
                //                         //Ticketemp."Purchase invoice Created":=FALSE;
                //                         //Ticketemp."Purchase Invoice No.":='';
                //                         Ticketemp."Purchase invoice Tcreate" := false;
                //                         Ticketemp."TPurchase Invoice No." := '';
                //                         //Ticketemp."Traitement effectué":=FALSE;




                //                         Ticketemp.MODIFY;
                //                     end;



                //                 until Ticket.NEXT = 0;
                //             MESSAGE('Opération terminé');
                //             Windows.CLOSE;
                //         end;
                //     }
                //     action("Annulation Ticket")
                //     {
                //         CaptionML = ENU = 'Ticket Cancel', FRA = 'Annulation Ticket';

                //         trigger OnAction()
                //         begin
                //             CheckAdminTicket; // vérification du droit Administrateur des tickets

                //             if CONFIRM('­tes vous sûre de vouloir annuler ce ticket %1 ?', false, "Ticket Planteur") then begin
                //                 "Ticket annule" := true;
                //                 MODIFY;
                //                 MESSAGE('Ticket %1 annulée avec succès', "Ticket Planteur");
                //             end;
                //         end;
                //     }
                //     action("Change Posting Date")
                //     {
                //         CaptionMl = ENU = 'Change Codes', FRA = 'Correction code Planteurs / Fournisseurs';
                //         Image = UpdateShipment;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         ToolTip = 'Bouton qui permet de mettre à jour l''origine d''un ticket non facturé';

                //         trigger OnAction()
                //         var
                //             ChangeCode: Report "Code Fournisseur ticket Update";
                //         begin
                //             ChangeCode.SetItemWeigh(Rec);
                //             ChangeCode.RUNMODAL;
                //             CurrPage.UPDATE;
                //         end;
                //     }
                // }

                // group("Annulation_Tickets_Trans_et_Plan")
                // {
                //     captionML = FRA = 'Annulation Validation Tickets Transport et Planteur', ENU = 'Cancellation Validation Tickets Transport et Planteur';
                //     action("Modèle importation tickets")
                //     {
                //         Promoted = true;
                //         Image = ImportExport;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = Report "Modele Import ticket";
                //     }
                //     action("Importation des tickets")
                //     {
                //         Promoted = true;
                //         Image = ImportExcel;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = Report "Importation des tickets";
                //     }
                //     action("Annuler Validation Tickets Transport/Planteur")
                //     {
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         PromotedIsBig = true;
                //         RunObject = Report "Annuler Validation tickets";

                //     }
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
    begin

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
            rec.Modify();
            TransFertTicketFromItemWeigntToBridgeCaisse();
            TicketPlanteur();
            if (rec."Statut paiement" = true) OR (rec."Type opération" = 'ACHAT COMPTANT') then begin
                Rec.Statut_Total_Paiement := true;
                rec.Modify();
            end;
        end;
    end;
}

