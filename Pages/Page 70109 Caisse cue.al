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
                Caption = 'Tickets non payés du jour';
                field("Ticket du jour"; rec."Ticket du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) Transporteur du jour non payés';
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
                field("Ticket du jour Planteur"; rec."Ticket du jour Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;
                    Caption = 'Ticket(s) Planteur du jour non payés';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement Planteur", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
                    end;
                }
                field("Ticke Anterieur non paye"; REC."Ticke Anterieur non paye")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Tickets Transporteurs antérieurs non payés';

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
                field("Ticke Anterieur non paye Planteur"; "Ticke Anterieur non paye Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Caption = 'Tickets Planteurs antérieurs non payés ';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.SetFilter("Date validation", '<%1', WorkDate);
                        ItemWeighBridge.SetRange(valide, true);
                        ItemWeighBridge.SetRange("Statut paiement Planteur", false);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
                    end;
                }
            }
            cuegroup("Ticket(s) facturé(s)")
            {
                Caption = 'Tickets payés jour';
                field("Ticket(s) Facturé(s) du jour"; "Ticket(s) Facturé(s) du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Transporteur du jour payés';
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
                field("Ticket(s) Facturé(s) du jour Planteur"; "Ticket(s) Facturé(s) du jour Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Planteur du jour payés"';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement Planteur", true);
                        ItemWeighBridge.FindFirst();
                        Page.RunModal(Page::"Item Weight Bridge", ItemWeighBridge);
                    end;
                }

            }
            cuegroup("Tickets payés")
            {
                field("Ticket(s) Facturé(s) Planteur";"Ticket(s) Facturé(s) Planteur")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Visible = true;

                    Caption = 'Ticket(s) Planteurs payés"';
                    trigger OnDrillDown()
                    var
                        ItemWeighBridge: Record "Item Weigh Bridge";
                    begin
                        // ItemWeighBridge.setFilter("Date validation", '=%1', WorkDate());
                        ItemWeighBridge.SetRange("Statut paiement Planteur", true);
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