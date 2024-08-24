page 70051 "Dépots clients"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    Editable = false;
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
                    /*field("Balance Due (LCY)"; "Balance Due (LCY)")
                    {
                        Caption = 'Solde client';
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
                            "Crédits" := 0;
                            if SaleInvHeader.FindFirst() then begin
                                Page.Run(143, SaleInvHeader);
                            end;
                        end;
                    }*/
                    field("Dépôts"; rec."Dépôts")
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

                    }
                }
            }
            group(totaux)
            {
                field("TotalDépots"; "TotalDépots")
                {
                    Caption = 'Total des dépots';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        customer: record Customer;
    begin
        "TotalDépots" := 0;
        customer.SetFilter("Dépôts", '>0');
        if customer.FindFirst() then begin
            repeat
                customer.CalcFields("Dépôts");
                "TotalDépots" += customer."Dépôts";
            until customer.Next = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        SaleInvHeader: Record "Sales Invoice Header";
        amnt: Decimal;
    begin
        SaleInvHeader.SetRange("Sell-to Customer No.", "No.");
        SaleInvHeader.setRange(CreditP, true);
        SaleInvHeader.SetRange(Closed, false);
        amnt := 0;
        if SaleInvHeader.FindFirst() then begin
            repeat
                SaleInvHeader.CalcFields("Remaining Amount");
                amnt += SaleInvHeader."Remaining Amount";
            until SaleInvHeader.Next = 0;
        end;
        rec."Crédits" := amnt;
        rec.Modify();
    end;

    var
        TotalDépots: Decimal;
        Crédits: Integer;
}