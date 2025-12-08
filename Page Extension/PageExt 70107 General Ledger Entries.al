pageextension 70107 "General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field(Reversed; Reversed)
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