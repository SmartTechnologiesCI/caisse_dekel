page 70053 "Liste des clients à crédit"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    CardPageId = "Customer Card";
    Editable = false;
    SourceTableView = where("Credit Amount (LCY)" = filter('>0'));
    layout
    {
        area(Content)
        {
            repeater("Liste des clients")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field("Credit Limit (LCY)"; "Credit Limit (LCY)")
                {
                    Caption = 'Limite de crédit';
                    ApplicationArea = All;
                }
                field("Limit credit time"; "Limit credit time")
                {
                    Caption = 'Délais (jours)';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        myInt: Integer;
}