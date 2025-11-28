tableextension 70029 "Item Weigh Bridge" extends "Item Weigh Bridge"
{
    fields
    {
        field(55005; Statut_Total_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entièrement payé';
        }
        field(55006; Ticket_Concerne; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ticket(s) Concerné(s)';
        }
        field(55007; NumDocExten; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(55008; Telephone; Code[25])
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