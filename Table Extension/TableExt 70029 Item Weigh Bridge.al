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
        field(55009; En_Attente_Paiement; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'En attente de paiement';
        }
        field(55010; TotalPlanteur; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Achat planteur';
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