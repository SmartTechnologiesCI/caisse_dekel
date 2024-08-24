page 70039 "Directrice activity"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Director Cue";
    Caption = 'La Tulipe Food';
    //RefreshOnActivate = true;
    layout
    {
        area(Content)
        {

            cuegroup("Statistiques journalieres")
            {
                CuegroupLayout = Wide;
                field("Total Ventes du jours"; invoiceTotal)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        saleInvoice: Record "Sales Invoice Header";
                    begin
                        saleInvoice.SetFilter("Order Date", '=%1', WorkDate());
                        Page.RunModal(Page::"Posted Sales Invoices", saleInvoice);
                    end;
                }
                field("Total Transactions du jours"; rec."Total Transactions du jours")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: Record "Transactions";
                    begin
                        trans.SetFilter("Date", '=%1', WorkDate());
                        Page.RunModal(Page::"Liste des transactions", trans);
                    end;
                }
                field("Total Transactions Espèces du jours"; rec."Total Espèces du jours")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: Record "Transactions";
                    begin
                        trans.SetFilter("Date", '=%1', WorkDate());
                        trans.SetFilter("Mode de reglement", '=%1', 'ESPÈCES');
                        Page.RunModal(Page::"Liste des transactions", trans);
                    end;
                } /**/
                field("Total des entrées"; rec."Total des entrées")
                {

                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: Record "Mouvements Entrees Sorties";
                    begin
                        trans.Reset();
                        trans.SetRange(type, trans.type::Entree);
                        trans.SetRange(Date, WorkDate());
                        if trans.FindFirst() then
                            Page.RunModal(70063, trans);
                    end;
                }
                field("Total des sorties"; rec."Total des sorties")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: Record "Mouvements Entrees Sorties";
                    begin
                        trans.Reset();
                        trans.SetRange(type, trans.type::Sortie);
                        trans.SetRange(Date, WorkDate());
                        if trans.FindFirst() then
                            Page.RunModal(70063, trans);
                    end;
                }
                field("Total dépôts"; rec."Total dépôts")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: record Transactions;
                    begin
                        trans.setRange(Source, trans.Source::Depot);
                        trans.SetRange(Date, WorkDate());
                        if trans.FindFirst() then
                            Page.RunModal(70002, trans);
                    end;
                }
                /*    Remove Smart Olivier
                            field("Montant épargne"; rec."Montant épargne")
                                {
                                    Caption = 'Total des épargnes client';
                                    ApplicationArea = All;
                                    DrillDown = true;
                                    trigger OnDrillDown()
                                    var
                                        customer: Record Customer;
                                    begin
                                        customer.SetFilter("Montant prime bonus", '>%1', 0);
                                        customer.FindFirst();
                                        Page.RunModal(70049, customer);
                                    end;
                                }*/
                field("Total recouvrement"; rec."Total recouvrement")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        trans: record Transactions;
                    begin
                        trans.setRange(Source, trans.Source::Facture);
                        trans.SetRange(recouvrement, true);
                        trans.SetRange(Date, WorkDate());
                        if trans.FindFirst() then
                            Page.RunModal(70002, trans);
                    end;
                }
            }
            cuegroup("Point de caisse")
            {
                CuegroupLayout = Wide;
                // field("Total Espèces Attendu du jours"; rec."Total Espèces du jours")
                // {
                //     Caption = 'Total des espèces attendus';
                //     ApplicationArea = All;
                //     DrillDown = true;

                //     trigger OnDrillDown()
                //     var
                //         trans: Record "Transactions";
                //     begin
                //         trans.SetFilter("Date", '=%1', WorkDate());
                //         trans.SetFilter("Mode de reglement", '=%1', 'ESPÈCES');
                //         Page.RunModal(Page::"Liste des transactions", trans);
                //     end;
                // }
                field("Total crédits en cours"; rec."Total crédits en cours")
                {
                    Caption = 'Total crédits en cours';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetRange(CreditP, true);
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.Run(70061);
                    end;
                }

            }/*/*
          /*field("Espèce caisse 1"; "Espèce caisse 1")
          {
              Caption = 'Total des espèces attendus';
              ApplicationArea = All;
              DrillDown = true;                    
          }
          field("Espèce caisse 2"; "Espèce caisse 2")
          {
              Caption = 'Total des espèces attendus';
              ApplicationArea = All;
              DrillDown = true;                    
          }*/
             /*  }*/

            cuegroup(Approbations)
            {
                field(DepotsCorrectionAttente; rec.DepotsCorrectionAttente)
                {
                    Caption = 'Dépot en attente';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Depôt";
                    begin
                        // DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                        DepotJour.SetRange(DemandeApprobation, true);
                        DepotJour.SetRange(Correction, false);
                        DepotJour.SetRange(validated, false);
                        Page.RunModal(Page::"Dépôts", DepotJour);
                    end;
                }

                field(DuplicataAttente; rec.DuplicataAttente)
                {
                    Caption = 'Duplicata en attente';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Sales Invoice Header";
                    begin

                        DepotJour.SetRange("Demande approbation", true);
                        DepotJour.SetRange(Approuve, false);
                        Page.RunModal(Page::"Liste des factures", DepotJour);
                    end;
                }

            }
            // cuegroup("ContratAchat")
            // {
            //     CaptionML = FRA = 'Contrats achat', ENU = 'Purchase Orders';
            //     field("Conteneurs en Chargement"; "Conteneurs en chargement")
            //     {
            //         ApplicationArea = All;
            //         DrillDown = true;
            //         trigger OnDrillDown()
            //         var
            //             purchaseOrder: Record "purchase Header";
            //         begin
            //             purchaseOrder.SetRange(Situaion, purchaseOrder.Situaion::"Loaded");
            //             if (purchaseOrder.FindFirst()) then
            //                 Page.Run(Page::"Purchase Order List", purchaseOrder)
            //             else
            //                 Error('Aucun conteneur n''est en Chargement');
            //         end;
            //     }
            //     field("Conteneurs Embarqués"; "Conteneurs Embarqués")
            //     {
            //         ApplicationArea = All;
            //         DrillDown = true;
            //         trigger OnDrillDown()
            //         var
            //             purchaseOrder: Record "purchase Header";
            //         begin
            //             purchaseOrder.SetRange(Situaion, purchaseOrder.Situaion::"Embedded");
            //             //purchaseOrder.SetRange("Code preparateur", UserId);
            //             if (purchaseOrder.FindFirst()) then
            //                 Page.Run(Page::"Purchase Order List", purchaseOrder)
            //             else
            //                 Error('Aucun conteneur n''est embarqué');
            //         end;
            //     }
            //     field("Conteneurs en Approche"; "Conteneurs en Approche")
            //     {
            //         ApplicationArea = All;
            //         DrillDown = true;
            //         trigger OnDrillDown()
            //         var
            //             purchaseOrder: Record "Purchase Header";
            //         begin
            //             purchaseOrder.SetRange(Situaion, purchaseOrder.Situaion::Dumped);
            //             //purchaseOrder.SetRange("Code preparateur", UserId);
            //             if (purchaseOrder.FindFirst()) then
            //                 Page.Run(Page::"Purchase Order List", purchaseOrder)
            //             else
            //                 Error('Aucun conteneur n''est en approche');
            //         end;
            //     }
            //     field("Conteneurs à depoter"; "Conteneurs à depoter")
            //     {
            //         ApplicationArea = All;
            //         DrillDown = true;
            //         Visible = false;
            //         trigger OnDrillDown()
            //         var
            //             Purchorder: Record "Purchase Header";
            //         begin
            //             Purchorder.SetRange(Depotage, true);
            //             if (Purchorder.FindFirst()) then
            //                 Page.Run(Page::"Purchase Order List", Purchorder)
            //             else
            //                 Error('Aucune commande n''est en Depotage');
            //         end;
            //     }/**/

            // }
            cuegroup(Commandes)
            {
                CaptionML = ENU = 'Sales Order', FRA = 'Commandes ventes';
                field("Commande en cours"; Rec."Commande en cours")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        salesOrder: Record "Sales Header";
                    begin
                        salesOrder.setRange("Document Type", salesOrder."Document Type"::Order);
                        salesOrder.setRange(Status, salesOrder.Status::Open);
                        salesOrder.setRange("Order Date", WorkDate());
                        if salesOrder.FindFirst() then
                            Page.run(Page::"Sales Order List", salesOrder);
                    end;

                }
                field("Commande lancée"; Rec."Commande lancee")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        salesOrder: Record "Sales Header";
                    begin
                        salesOrder.setRange("Document Type", salesOrder."Document Type"::Order);
                        salesOrder.setRange(Status, salesOrder.Status::Released);
                        //salesOrder.setRange("Order Date", WorkDate());
                        if salesOrder.FindFirst() then
                            Page.run(Page::"Sales Order List", salesOrder);
                    end;

                }
                /*field("Article paye non livre"; Rec."Article paye non livre")
                {
                    ApplicationArea = All;
                    DrillDown = true;



                    trigger OnDrillDown()
                    var
                        SIL: record "Sales Invoice Header";
                        ArticlePayeNonLivre: Page 70006;
                    begin
                        //On ouvre une page special contenant la liste des artciles
                        Page.Run(70006); // list des articles payees non livrées

                    end;



                }*/
            }

            cuegroup("Factures en attente de paiement")
            {
                field("Factures du jour"; rec."Factures du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetRange("Order Date", WorkDate);
                        factureJour.SetRange(Closed, false);
                        factureJour.SetRange("Statut Livraison", factureJour."Statut Livraison"::"Non payée");
                        factureJour.FindFirst();
                        Page.RunModal(143, factureJour);
                    end;

                }
                field("Factures douanieres"; rec."Factures douanieres")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Facture douanieres';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        salesInvoiceHeader: Record "Sales Invoice Header";
                    begin
                        salesInvoiceHeader.SetRange("Est Echantillone", true);
                        salesInvoiceHeader.SetRange("Due Date", WorkDate());
                        salesInvoiceHeader.FindSet();
                        Page.Run(143, salesInvoiceHeader);
                    end;

                } /**/
            }
            cuegroup("Crédist&Dépots")
            {
                Caption = 'Crédits';
                field("Factures à crédit"; rec."Factures à crédit")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.SetRange(CreditP, true);
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();

                        Page.RunModal(143, factureJour);
                    end;
                }
                // field("Depots du jour"; "Depots du jour")
                // {
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     trigger OnDrillDown()
                //     var
                //         DepotJour: Record "Depôt";
                //     begin
                //         DepotJour.SetRange(Date, WorkDate);
                //         DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                //         DepotJour.SetFilter(Montant, '>%1', 0);
                //         Page.RunModal(Page::"Dépôts", DepotJour);
                //     end;
                // }
            }
            /*    cuegroup("Comptes de tiers")
                {
                    Caption = 'Comptes de tiers';
                    /*       field(debiteur; debiteur)
                           {
                               Caption = 'Nos débiteurs';
                               ApplicationArea = All;
                               DrillDown = true;
                               Image = Person;
                               Visible = false;
                               trigger OnDrillDown()
                               var
                                   customer: Record Customer;
                               begin
                                   customer.SetFilter("Dépôts", '>%1', 0);
                                   customer.FindFirst();
                                   Page.RunModal(70051, customer);
                               end;
                           }
            field(crediteur; rec.crediteur)
            {
                Caption = 'Dépôts actifs';
                ApplicationArea = All;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    customer: Record Customer;
                begin
                    customer.SetFilter("Dépôts", '>0');
                    customer.FindFirst();
                    Page.RunModal(70051, customer);
                end;
            }
                field("Depots Actifs"; "Depots Actifs")
                {
                    Caption = 'Dépôts du jour';
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        depots: Record Depôt;
                    begin
                        depots.SetFilter("Montant", '>%1', 0);
                        depots.SetFilter(Date, '=%1', WorkDate());
                        depots.FindFirst();
                        Page.RunModal(70051, depots);
                    end;
                }
            field("Depots Bonus"; rec."Depots Bonus")
            {
                Caption = 'Compte épargne clients';
                ApplicationArea = All;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    customer: Record Customer;
                begin
                    customer.SetFilter("Montant prime bonus", '>0');
                    customer.FindFirst();
                    Page.RunModal(70049, customer);
                end;
            }
        }*/

            cuegroup("Articles et prix")
            {
                field("Available items"; rec."Available items")
                {
                    Caption = 'Articles disponibles';
                    DrillDown = true;
                    //Visible = false;
                    trigger OnDrillDown()
                    var
                        items: Record Item;
                    begin
                        items.SetFilter(Inventory, '>0');
                        if items.FindFirst() then
                            Page.Run(50018, items);
                    end;
                }
                field("Commandes prix à fixer"; rec."Commandes prix à fixer")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        "PurchOrder": Record "Purchase Header";
                    begin
                        PurchOrder.SetRange("Prix fixé", false);
                        PurchOrder.SetRange("Fixation des prix", true);
                        PurchOrder.SetFilter(ETA, '>%1', DMY2Date(23, 03, 2021));
                        PurchOrder.FindFirst();
                        Page.RunModal(70040, PurchOrder);
                    end;
                }
            }   /**/

            /**/

            cuegroup("Factures annulees")
            {
                Caption = 'Factures annulées du jour';
                field("Annulées"; rec."Annulées")
                {
                }
            }/* */


        }

    }


    actions
    {
    }
    trigger OnOpenPage()
    var
        salesInvHeader: Record "Sales Invoice Header";
    begin
        if not Get() then begin
            Init();
            Insert();
            CurrPage.Update();// smart olivier
        end;



        salesInvHeader.SetRange(CreditP, true);
        salesInvHeader.SetRange(Closed, false);
        rec."Total crédits en cours" := 0;
        if salesInvHeader.FindFirst() then begin
            repeat
                salesInvHeader.CalcFields("Remaining Amount");
                rec."Total crédits en cours" += salesInvHeader."Remaining Amount";
                rec.Modify();
            until salesInvHeader.Next = 0;
        end;

        SetFilter("Date Filter", '=%1', WorkDate());
        SetFilter(dateFilter, '=%1', WorkDate());
        SetFilter("date filter 2", '<%1', WorkDate());
        SetFilter("date filter 3", '>%1', DMY2Date(23, 03, 2021));
        SetFilter(balanceFilter, '>%1', 0);
        SetFilter(balanceFilter2, '<%1', 0);

        //Smart olivier 280222

        saleInvoice.SetFilter("Order Date", '=%1', WorkDate());
        invoiceTotal := 0;
        if saleInvoice.FindFirst() then
            repeat
                saleInvoice.CalcFields("Amount Including VAT");
                invoiceTotal += saleInvoice."Amount Including VAT";
            until saleInvoice.Next = 0;
        CurrPage.Update();

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
    end;

    var
        saleInvoice: Record "Sales Invoice Header";
        invoiceTotal: Decimal;

}