pageextension 70010 "Sales setup" extends 459
{
    layout
    {
        // Add changes to page layout here
        addafter("Quote Validity Calculation")
        {
            field("Montant Bonus"; rec."Montant epargne")
            {

            }
            field("Montant epargne Max"; rec."Montant epargne Max")
            {

            }
            field("Type Bonus"; rec."Type epargne")
            {

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