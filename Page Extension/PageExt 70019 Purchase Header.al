pageextension 70019 PurchaseHeader extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Autorisation de change"; rec."Autorisation de change") { }
            field(Banque; rec.Banque) { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}