pageextension 70003 "Posted SalesShip" extends 130
{
    layout
    {
        addafter("Order No.")
        {
            field("Payment DateTime"; rec."Payment DateTime")
            {
                Caption = 'Date et heure de paiement';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}