tableextension 70017 "Invoice Post. BufferX" extends "Invoice Post. Buffer"
{
    fields
    {
        field(90003; "Lot Qty."; Integer)
        {
            CaptionML = ENU = 'Boxes Number', FRA = 'Nombre de cartons';
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