tableextension 70024 "Transfer Shipment LineExt" extends "Transfer Shipment Line"
{
    fields
    {
        field(50000; "Nombre de carton"; Integer)
        {
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