page 70109 "Caisse cue"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 9055;

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                field("Ticket du jour"; rec."Ticket du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = false;
                    Caption = 'Ticket(s) du jour';
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";
                    begin
                        factureJour.setFilter("Order Date", '=%1', WorkDate());
                        factureJour.SetRange(Closed, false);
                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures", factureJour);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}