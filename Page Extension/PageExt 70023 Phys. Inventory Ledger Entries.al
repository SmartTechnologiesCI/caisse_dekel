pageextension 70023 "Phys. Invent. Led. EntriesExt" extends "Phys. Inventory Ledger Entries"
{
    layout
    {
        addafter(Quantity)
        {
            field("Nombre de carton";rec."Nombre de carton"){
                ApplicationArea=All;
            }
            field("Nombre de cartonc"; rec."Nombre de cartonc")
            {
                ApplicationArea = All;
            }
            field("Diff Qty carton"; rec."Diff Qty carton")
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