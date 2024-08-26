tableextension 70020 "Purch. Cr. Memo LineExt" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(90003; "Lot Qty"; Integer)
        {
            Caption='Nombre de cartons';
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        // Add changes to keys here
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
        pag:page 137;
}