tableextension 70019 "Purch. Inv. LineX" extends "Purch. Inv. Line"
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
}