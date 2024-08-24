page 70041 "Compte tiers activity"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Director Cue";
    Caption = 'Compte Tiers';
    //RefreshOnActivate = true;
    layout
    {
        area(Content)
        {

            cuegroup("Comptes de tiers")
            {
                ShowCaption = false;
                Caption = 'Comptes de tiers';

                field(crediteur; rec.crediteur)
                {
                    Caption = 'Dépôts actifs';
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        customer.Reset();
                        customer.SetFilter("Dépôts", '>0');
                        if customer.FindFirst() then begin
                            Page.RunModal(70051, customer);
                        end;

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
                        customer.Reset();
                        customer.SetFilter("Montant prime bonus", '>0');
                        if customer.FindFirst() then begin
                            Page.RunModal(70049, customer);
                        end;

                    end;
                }
            }/**/



        }

    }


    actions
    {
    }
    trigger OnOpenPage()
    var
        salesInvHeader: Record "Sales Invoice Header";
    begin
        if not rec.Get() then begin
            rec.Init();
            rec.Insert();
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

        rec.SetFilter("Date Filter", '=%1', WorkDate());
        rec.SetFilter(dateFilter, '=%1', WorkDate());
        rec.SetFilter("date filter 2", '<%1', WorkDate());
        rec.SetFilter("date filter 3", '>%1', DMY2Date(23, 03, 2021));
        rec.SetFilter(balanceFilter, '>%1', 0);
        rec.SetFilter(balanceFilter2, '<%1', 0);

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