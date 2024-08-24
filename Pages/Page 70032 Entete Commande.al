page 70032 "Entete commande"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 112;

    layout
    {
        area(Content)
        {

            group(Général)
            {
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                    Caption = 'N° Client';
                    Editable = false;
                    Style = Strong;
                }
                field("Bill-to Name"; rec."Bill-to Name")
                {
                    Caption = 'Client';
                    Editable = false;
                    Style = Strong;
                }
                field("Dépôts"; "Dépôts")
                {
                    Caption = 'Dépôts client';
                    Editable = false;
                    Style = StrongAccent;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Depots: Record Depôt;
                    begin
                        Depots.SetRange("N° client", "Sell-to Customer No.");
                        if (Depots.FindFirst()) then begin

                            pAGE.Run(70003, Depots);
                        end;
                    end;
                }
                field("Crédit"; "crédit")
                {
                    Style = StrongAccent;
                    trigger OnDrillDown()
                    var
                        SaleInvHeader: record "Sales Invoice Header";
                    begin
                        SaleInvHeader.Reset();
                        SaleInvHeader.SetRange("Sell-to Customer No.", rec."No.");
                        SaleInvHeader.setRange(CreditP, true);
                        SaleInvHeader.SetRange(Closed, false);
                        if SaleInvHeader.FindFirst() then begin
                            Page.Run(70028, SaleInvHeader);
                        end;
                    end;
                }
                field("Limite de crédits"; "Limit crédit")
                {
                    Style = Strong;
                }
                field("Order Date"; rec."Order Date")
                {
                    Caption = 'Date de commande';
                    Editable = false;
                }
                field("Date"; "Date")
                {
                    Caption = 'Date de paiement';
                    Editable = false;
                }
            }
            group("Règlement")
            {
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Caption = 'Montant TTC';
                    Style = Strong;
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Montant payé"; (rec."Amount Including VAT" + rec.timbre) - (rec."Remaining Amount" + timbre))
                {
                    Caption = 'Montant reglé';
                    Style = Strong;
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Caption = 'Montant TTC NET';
                    Style = Strong;
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Reste à payer"; "Reste à payer")
                {
                    Style = Unfavorable;
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnOpenPage()
    var
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        amnt: Decimal;
        customer: Record Customer;
    begin
        /*customer.Reset();
        "Limit crédit" := 0;

        customer.SetRange("No.", rec."Bill-to Customer No.");
        if customer.FindFirst() then begin
            "Limit crédit" := customer."Credit Limit (LCY)";
            SaleInvHeader2.Reset();
            SaleInvHeader2.SetRange("Bill-to Customer No.", rec."No.");
            SaleInvHeader2.setRange(CreditP, true);
            SaleInvHeader2.SetRange(Closed, false);
            amnt := 0;
            if SaleInvHeader2.FindFirst() then begin
                repeat
                    SaleInvHeader2.CalcFields("Remaining Amount");
                    amnt += SaleInvHeader2."Remaining Amount";
                until SaleInvHeader2.Next = 0;
            end;
            customer."Crédits" := amnt;
            "crédit" := amnt;
            customer.Modify();
            CurrPage.Update();
        end;*/
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        amnt: Decimal;
        customer: Record Customer;
    begin
        customer.Reset();
        "Limit crédit" := 0;

        customer.SetRange("No.", rec."Bill-to Customer No.");
        if customer.FindFirst() then begin
            "Limit crédit" := customer."Credit Limit (LCY)";
            SaleInvHeader2.Reset();
            SaleInvHeader2.SetRange("Bill-to Customer No.", customer."No.");
            SaleInvHeader2.setRange(CreditP, true);
            SaleInvHeader2.SetRange(Closed, false);
            amnt := 0;
            if SaleInvHeader2.FindFirst() then begin
                repeat
                    SaleInvHeader2.CalcFields("Remaining Amount");
                    amnt += SaleInvHeader2."Remaining Amount";
                until SaleInvHeader2.Next = 0;
            end;
            customer."Crédits" := amnt;
            "crédit" := amnt;
            customer.Modify();
            CurrPage.Update();
        end;

        "Date" := WorkDate;
        "Reste à payer" := ("Remaining Amount" + timbre);
        depot.SetRange("N° client", "sell-to Customer No.");
        depot.SetRange(validated, true);
        depot.SetRange(isBonus,false);
        if depot.FindFirst() then begin
            "Dépôts" := 0;
            repeat
                "Dépôts" += depot.Montant;
            until depot.Next = 0;
        end;
    end;


    var
        //customer: Record Customer;
        depot: Record "Depôt";
        "Date": Date;
        "Montant reglé": Decimal;
        "Dépôts": Decimal;
        "crédit": Decimal;
        "Limit crédit": Decimal;
        "Reste à payer": Decimal;
}