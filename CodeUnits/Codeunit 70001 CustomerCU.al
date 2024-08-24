codeunit 70001 "CustomerCU"
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    procedure UpdateCredit()
    var
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        cutomer: record customer;
        amnt: Decimal;
    begin
        cutomer.Reset();
        cutomer.SetFilter("Credit Limit (LCY)", '>0');
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
    end;

    procedure UpdateCustCredit("customer No.": Code[30])
    var
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        cutomer: record customer;
        amnt: Decimal;
    begin
        cutomer.Reset();
        cutomer.SetRange("No.", "customer No.");
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
    end;

    procedure UpdateAndGetCustCredit("customer No.": Code[30]): Decimal
    var
        SaleInvHeader: Record "Sales Invoice Header";
        SaleInvHeader2: Record "Sales Invoice Header";
        cutomer: record customer;
        amnt: Decimal;
    begin
        amnt := 0;
        cutomer.Reset();
        cutomer.SetRange("No.", "customer No.");
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
        exit(amnt);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeSetDefaultSalesperson', '', true, true)]
    procedure OnBeforeSetDefaultSalesperson(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        userPar: record "User Setup";
    begin
        SalesHeader."Assigned User ID" := UserId;
        userPar.SetRange("User ID", UserId);
        if (userPar.FindFirst()) then begin
            SalesHeader.Validate("Salesperson Code", userPar."Salespers./Purch. Code");
        end;
    end;
}