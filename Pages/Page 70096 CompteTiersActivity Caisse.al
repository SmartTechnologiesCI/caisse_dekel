page 70096 "Compte tiers activity Caisse"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Caisse Cue";
    Caption = 'Compte Tiers';
    //RefreshOnActivate = true;
    layout
    {
        area(Content)
        {

            cuegroup("Info Clients")
            {
                ShowCaption = false;
                Caption = 'Infos des clients';
                field(debiteur; rec.debiteur)
                {
                    Caption = 'Nos débiteurs';
                    ApplicationArea = All;
                    DrillDown = true;
                    Image = Cash;

                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        customer.SetFilter("Balance Due", '>%1', 0);
                        customer.FindFirst();
                        Page.RunModal(Page::"Liste des Clients", customer);
                    end;
                }
    

                      field("Depots Actifs"; rec."Depots Actifs")
                      {
                          Caption = 'Dépôts actifs';
                          ApplicationArea = All;
                          DrillDown = true;
                          trigger OnDrillDown()
                          var
                              customer: Record Customer;
                          begin
                              customer.SetFilter("Dépôts", '>%1', 0);
                              customer.FindFirst();
                              Page.RunModal(70051, customer);
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




        rec.SetFilter("Date Filter", '=%1', WorkDate());
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