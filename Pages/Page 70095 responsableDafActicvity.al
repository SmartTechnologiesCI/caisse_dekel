page 70095 "ResponsableDaf activity"
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
                field("Total Espèces Attendu du jours"; rec."Total Espèces du jours")
                {
                    Caption = 'Total des espèces attendus';
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
                }


            }


            cuegroup(Approbations)
            {
                field(DepotsCorrectionAttente; rec.DepotsCorrectionAttente)
                {
                    Caption = 'Correction dépot en attente';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        DepotJour: Record "Depôt";
                    begin
                        // DepotJour.SetRange("Code Caisse", caisse."Code caisse");
                        // silue samuel 07/03/2025 DepotJour.SetRange(DemandeApprobation, true);
                        DepotJour.SetRange(Correction, false);
                        DepotJour.SetRange(validated, false);
                        Page.RunModal(Page::"Dépôts", DepotJour);
                    end;
                }

            }   /**/



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
        // silue samuel 07/03/2025 Item:Record Item;

}