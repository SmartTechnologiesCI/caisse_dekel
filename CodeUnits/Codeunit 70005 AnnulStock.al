codeunit 70005 "Annuler Stock Negatif"
{
    trigger OnRun()
    var
        inv: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";

    begin


        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetRange(Quantity, 0);
        if ItemLedgerEntry.FindFirst() then
            repeat
            begin

                ItemLedgerEntry.Quantity := ItemLedgerEntry."Invoiced Quantity";
                ItemLedgerEntry.Modify();
            end;
            until ItemLedgerEntry.Next() = 0;
    end;


    var
        myInt: Integer;
        Item: Record "Sales Line";

}