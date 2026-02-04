pageextension 70111 "Purchase DA Agent Activities" extends "Purchase DA Agent Activities"
{
    layout
    {
        addafter("Pre-arrival Follow-up on Purchase Orders")
        {
            cuegroup("AnnutionTicket")
            {
                Caption = 'Annulatin de tickets';
                field(EnvoyEnAnnulation; EnvoyEnAnnulation)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                    end;

                }
                field(DemandeAutorisation; DemandeAutorisation)
                {

                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                    end;
                }
                field(TicketAAnnule; TicketAAnnule)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                    end;
                }
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