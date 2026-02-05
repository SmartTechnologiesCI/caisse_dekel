pageextension 70118 "Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter("No.")
        {
            field(ModeleFournisseur; REC.ModeleFournisseur)
            {
                ApplicationArea = All;
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