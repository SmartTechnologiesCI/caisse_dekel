page 70061 "Soldes clients"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
    //SourceTableView = where("Credit Limit (LCY)" = filter('>0'));
    layout
    {
        area(Content)
        {
            group("Soldes clients")
            {
                repeater("")
                {
                    field("No."; "No.")
                    {
                        ApplicationArea = All;

                    }
                    field("Name"; Name)
                    {
                        ApplicationArea = All;

                    }
                    field("Credit Limit (LCY)"; "Credit Limit (LCY)")
                    {

                        Caption = 'Limite de crédit client';
                    }
                    field(Crédits; Crédits)
                    {
                        ApplicationArea = All;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            SaleInvHeader: Record "Sales Invoice Header";
                        begin
                            SaleInvHeader.SetRange("Sell-to Customer No.", "No.");
                            SaleInvHeader.setRange(CreditP, true);
                            SaleInvHeader.SetRange(Closed, false);
                            //SaleInvHeader.SetFilter("Crédits", '>0');
                            if SaleInvHeader.FindFirst() then begin
                                Page.Run(143, SaleInvHeader);
                            end;
                        end;
                    }
                    /*field("Dépôts"; "Dépôts")
                    {
                        ApplicationArea = All;
                        trigger OnDrillDown()
                        var
                            depot: Record "Depôt";
                        begin
                            depot.setRange("N° client", rec."No.");
                            if depot.FindFirst() then begin
                                Page.Run(70003, depot);
                            end;
                        end;

                    }*/
                }
            }
            field("Total Facture Credit"; "Total Facture Credit")
            {
                Caption = 'Total des factures à crédit';
                Style = Strong;
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    var
        "Total Facture Credit": Decimal;

    trigger OnOpenPage()
    var
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        cutomer: record customer;
        amnt: Decimal;
    begin
        cutomer.Reset();
        //cutomer.SetFilter("Credit Limit (LCY)", '>0');
        // cutomer.CalcFields(cred)
        if cutomer.FindFirst() then begin
            repeat
                SaleInvHeader2.Reset();
                SaleInvHeader2.SetRange("Sell-to Customer No.", cutomer."No.");
                SaleInvHeader2.setRange(CreditP, true);
                SaleInvHeader2.SetRange(Closed, false);
                amnt := 0;
                if SaleInvHeader2.FindFirst() then begin
                    repeat
                        SaleInvHeader2.CalcFields("Remaining Amount");
                        amnt += SaleInvHeader2."Remaining Amount";
                    until SaleInvHeader2.Next = 0;
                end;
                cutomer."Crédits" := amnt;
                cutomer.Modify();
            until cutomer.Next = 0;

        end;

        SaleInvHeader.Reset();
        SaleInvHeader.setRange(CreditP, true);
        SaleInvHeader.SetRange(Closed, false);
        "Total Facture Credit" := 0;
        if SaleInvHeader.FindFirst() then begin
            repeat
                SaleInvHeader.CalcFields("Remaining Amount");
                "Total Facture Credit" += SaleInvHeader."Remaining Amount";
            until SaleInvHeader.Next = 0;
        end;


        Rec.SetFilter("Crédits", '>0');
        CurrPage.Update();
    end;

    /* trigger OnAfterGetRecord()
     var
         SaleInvHeader: Record "Sales Invoice Header";
     begin
         SaleInvHeader.SetRange("Sell-to Customer No.", rec."No.");
         SaleInvHeader.setRange(CreditP, true);
         SaleInvHeader.SetRange(Closed, false);
         rec."Crédits" := 0;
         if SaleInvHeader.FindFirst() then begin
             repeat
                 SaleInvHeader.CalcFields("Remaining Amount");
                 rec."Crédits" += SaleInvHeader."Remaining Amount";
             until SaleInvHeader.Next = 0;
         end;
     end;*/
}