function rects = create_rects(h, varargin)
    p = inputParser;
    % The figure handle
    addRequired(p, 'h');
    % The rectangles that are already drawn
    addParameter(p, 'PreviousRectangles', zeros(1,4) );
    
    parse(p, h, varargin{:});    
    previousRectangles = p.Results.PreviousRectangles;
    
    % set the current figure now
    figure(h);
    
    rects = int32(zeros(100,4));
    count = 0;
    answer = questdlg('Are there any features in the image?');
    while ( strcmp(answer, 'Yes') )
        count = count + 1;
        [x,y] = ginput(2);

        x = int32(x);
        y = int32(y);
        w = abs(x(1)-x(2));
        h = abs(y(1)-y(2));
        rects(count,:) = [x(1) y(1) w h];
        answer = questdlg('Do you want to add more rectangles?');
    end
end