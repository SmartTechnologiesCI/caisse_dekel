tableextension 70029 "Item Weigh Bridge" extends "Item Weigh Bridge"
{
    fields
    {
        field(55005; Statut_Total_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entièrement payé';
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