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
                Caption = 'Tickets non payés';
                field("Ticket du jour"; rec."Ticket du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) du jour';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
                    end;
                }
                field("Ticke Anterieur non paye"; REC."Ticke Anterieur non paye")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetFilter("Date validation", '<%1', WorkDate);
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
                    end;
                }
            }
            cuegroup("Ticket(s) facturé(s)")
            {
                Caption = 'Tickets payés';
                field("Ticket(s) Facturé(s) du jour"; "Ticket(s) Facturé(s) du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) du jour payés"';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement", true);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
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

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter("date filter 3", '=%', WorkDate());
        SetFilter("date filter 2", '<%', WorkDate());
    end;
}