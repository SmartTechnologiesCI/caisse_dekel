codeunit 70006 "Event Souscriber"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateQuantityOnBeforeCheckAssocPurchOrder', '', true, true)]
    local procedure OnValidateQuantityOnBeforeCheckAssocPurchOrder(var SalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    var
        Item: Record Item;
    begin
        Item.Reset();
        Item.SetRange("No.", SalesLine."No.");
        if Item.FindFirst() then begin
            Item.CalcFields(Inventory);
            if (Item.Inventory - SalesLine.Quantity) < -10 then begin
                Error('Le stock est biaisé, cherchez à augmenter votre stock');
            end;
        end;
    end;

    var
        myInt: Integer;
}