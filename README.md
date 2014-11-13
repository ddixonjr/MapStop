<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <title></title>
</head>
<body>
<h1>MapStop</h1>
<p>MapStop is a simple demo/portfolio app that displays a set of bus stops in the Chicago area.  Coded in response to a code challenge, I used good OO and iOS design patterns and created a clean separation of view and view controller responsibilties from those of the network interaction and model.</p>
<p>Primary Frameworks, Classes, and Protocols Utilized:<br>
<ul>
<li>Foundation (NSArray, NSDictionary, NSURLSession, NSURLSessionConfiguration, NSURLSessionDataTask, NSURLSessionDataDelegate)</li>
<li>UIKit (UIViewController, UITableViewController, UITableView, etc.)</li>
<li>MapKit (MKMapView, MKPointAnnotation, MKPinAnnotationView, MKMapViewDelegate)</li>
<li>Core Location (CLGeocoder, CLLocation, CLPlacemark)</li>
</ul>
</p>
<p>Primary Design Patterns, Coding Techniques, and iOS Capabilities Utilized:<br>
<ul>
<li>Delegation & Obj-C Protocols (Apple/GoF and Custom Application)</li>
<li>MVC (Apple and Custom Application)</li>
<li>Target-Action (Apple)</li>
<li>Composite (Apple)</li>
<li>ResponderChain/Chain of Responsibility (Apple)</li>
<li>Factory Method (Apple)</li>
<li>Basic GCD (dispatch_async(), dispatch_get_main_queue())</li>
<li>Obj-C Blocks (Apple and Custom Application)</li>
</ul>
</p>
<p>The class reference documentation below describes those responsibilities along with the APIs that facilitate interaction between the classes that make up the app.</p>
<p><br></p>
<h2>MapStop Hierarchy</h2>
<p class="p2">Class Hierarchy</p>
<ul class="ul1">
  <li class="li3">NSObject</li>
  <ul class="ul1">
    <li class="li4">MSTPStop</li>
    <li class="li4">MSTPStopsService</li>
  </ul>
  <li class="li3">UITableViewController</li>
  <ul class="ul1">
    <li class="li4">MSTPStopDetailTableViewController</li>
  </ul>
  <li class="li3">UIViewController</li>
  <ul class="ul1">
    <li class="li4">MSTPMapStopMainViewController</li>
  </ul>
</ul>
<p class="p5"><br></p>
<p class="p5"><br></p>
<h2>MSTPStop Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td2">
        <p class="p6">NSObject</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td2">
        <p class="p6">MSTPStop.h</p>
        <p class="p6">MSTPStop.m</p>
      </td>
    </tr>
  </tbody>
</table>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li8">  name<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  stopID<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  urlString<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  routes<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  direction<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  intermodalTransfers<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">  coordinate<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">– initWithLatitude:andLongitude:</li>
  <li class="li8">– fetchAddressWithCompletionHandler:</li>
</ul>
<h3>Properties</h3>
<p class="p9">coordinate</p>
<p class="p10">The geographical coordinate of this stop.</p>
<p class="p11">@property (assign, readonly, nonatomic) CLLocationCoordinate2D coordinate</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The geographical coordinate of this stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">direction</p>
<p class="p10">The direction of the <span class="s3">routes</span> at the stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *direction</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The direction of the <span class="s3">routes</span> at the stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">intermodalTransfers</p>
<p class="p10">The other modes of transportation available for transfer at this stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *intermodalTransfers</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The other modes of transportation available for transfer at this stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">name</p>
<p class="p10">The name of the transit stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *name</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The name of the transit stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">routes</p>
<p class="p10">The transit authority route numbers that service the stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *routes</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The transit authority route numbers that service the stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">stopID</p>
<p class="p10">The transit authority designated identification number of the stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *stopID</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The transit authority designated identification number of the stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">urlString</p>
<p class="p10">An NSString storing the transit authority URL for information regarding the stop.</p>
<p class="p11">@property (strong, nonatomic) NSString *urlString</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">An NSString storing the transit authority URL for information regarding the stop.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p7">Instance Methods</p>
<p class="p9">fetchAddressWithCompletionHandler:</p>
<p class="p10">Invokes reverse geolocation in the background to return an NSString holding the address via the completion handler.</p>
<p class="p11">- (void)fetchAddressWithCompletionHandler:(void ( ^ ) ( NSString *address , NSError *error ))<i>completion</i></p>
<p class="p12"><b>Parameters</b></p>
<p class="p14">completion</p>
<p class="p10">a completion block that provides the resulting address or an NSError object if unable to complete the reverse geolocation.</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">Invokes reverse geolocation in the background to return an NSString holding the address via the completion handler.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p9">initWithLatitude:andLongitude:</p>
<p class="p10">The designated initializer that facilitates instantiation with geolocation information at a minimum.</p>
<p class="p11">- (id)initWithLatitude:(CLLocationDegrees)<i>latitude</i> andLongitude:(CLLocationDegrees)<i>longitude</i></p>
<p class="p12"><b>Parameters</b></p>
<p class="p14">latitude</p>
<p class="p10">latitude of the stop.</p>
<p class="p14">longitude</p>
<p class="p10">longitude of the stop.</p>
<p class="p12"><b>Return Value</b></p>
<p class="p10">A stop object with the geographical <span class="s3">coordinate</span> property set.</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The designated initializer that facilitates instantiation with geolocation information at a minimum.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStop.h</p>
<p class="p15"><br></p>
<p class="p15"><br></p>
<h2>MSTPStopsService Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td3">
        <p class="p6">NSObject</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td3">
        <p class="p6">MSTPStopsService.h</p>
        <p class="p6">MSTPStopsService.m</p>
      </td>
    </tr>
  </tbody>
</table>
<h3>Tasks</h3>
<ul class="ul1">
  <li class="li8">  delegate<span class="s1"> </span><span class="s2">property</span></li>
  <li class="li8">– startPullOfStopSet:</li>
  <li class="li8">– numberOfStopsInMap</li>
  <li class="li8">– stopForStopAtIndex:</li>
</ul>
</h3>Properties</h3>
<p class="p9">delegate</p>
<p class="p10">The delegate object to receive callbacks defined in the <a href="file:///Users/Dennis/Library/Developer/Shared/Documentation/DocSets/com.appivot.mapstop.MapStop.docset/Contents/Resources/Documents/Protocols/StopsServiceDelegate.html"><span class="s3">StopsServiceDelegate</span></a> protocol</p>
<p class="p11">@property (weak, nonatomic) id&lt;StopsServiceDelegate&gt; delegate</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The delegate object to receive callbacks defined in the <a href="file:///Users/Dennis/Library/Developer/Shared/Documentation/DocSets/com.appivot.mapstop.MapStop.docset/Contents/Resources/Documents/Protocols/StopsServiceDelegate.html"><span class="s3">StopsServiceDelegate</span></a> protocol</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStopsService.h</p>
<p class="p7">Instance Methods</p>
<p class="p9">numberOfStopsInMap</p>
<p class="p10">Determines and returns the number of stops currently loaded in the StopsMap object.</p>
<p class="p11">- (NSInteger)numberOfStopsInMap</p>
<p class="p12"><b>Return Value</b></p>
<p class="p10">the number of stops currently loaded in the StopsMap object.</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">Determines and returns the number of stops currently loaded in the StopsMap object.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStopsService.h</p>
<p class="p9">startPullOfStopSet:</p>
<p class="p10">Starts an asynchronous pull of transit stop information. Upon completion the -stopsService:didPullStopsWithError: <span class="s3">delegate</span> method will be called</p>
<p class="p11">- (void)startPullOfStopSet:(NSString *)<i>stopSetURLString</i></p>
<p class="p12"><b>Parameters</b></p>
<p class="p14">stopSetURLString</p>
<p class="p10">An NSString specifying the URL. If nil, a default URL will be used.</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">Starts an asynchronous pull of transit stop information. Upon completion the -stopsService:didPullStopsWithError: <span class="s3">delegate</span> method will be called</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStopsService.h</p>
<p class="p9">stopForStopAtIndex:</p>
<p class="p10">Returns the Stop object at the specified index</p>
<p class="p11">- (MSTPStop *)stopForStopAtIndex:(NSInteger)<i>stopIndex</i></p>
<p class="p12"><b>Parameters</b></p>
<p class="p14">stopIndex</p>
<p class="p10">index of the Stop object being requested.</p>
<p class="p12"><b>Return Value</b></p>
<p class="p10">the Stop object corresponding to the specified index.</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">Returns the Stop object at the specified index</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStopsService.h</p>
<p class="p15"><br></p>
<p class="p15"><br></p>
<h2>MSTPStopDetailTableViewController Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td4">
        <p class="p6">UITableViewController</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td4">
        <p class="p6">MSTPStopDetailTableViewController.h</p>
        <p class="p6">MSTPStopDetailTableViewController.m</p>
      </td>
    </tr>
  </tbody>
</table>
<h3>Overview</h3>
<p class="p16">A view controller that facilitates the population of a view hierarchy displaying detailed transit authority stop information based on a populated Stop object passed in using the <span class="s3">selectedStop</span> property.</p>
<p class="p7">Tasks</p>
<ul class="ul1">
  <li class="li8">  selectedStop<span class="s1"> </span><span class="s2">property</span></li>
</ul>
<h3>Properties</h3>
<p class="p9">selectedStop</p>
<p class="p10">The stop object containing the detailed information to be displayed.</p>
<p class="p11">@property (strong, nonatomic) MSTPStop *selectedStop</p>
<p class="p12"><b>Discussion</b></p>
<p class="p10">The stop object containing the detailed information to be displayed.</p>
<p class="p12"><b>Declared In</b></p>
<p class="p13">MSTPStopDetailTableViewController.h</p>
<p class="p15"><br></p>
<p class="p15"><br></p>
<h2>MSTPMapStopMainViewController Class Reference</h2>
<table cellspacing="0" cellpadding="0" class="t1">
  <tbody>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Inherits from</b></p>
      </td>
      <td valign="top" class="td5">
        <p class="p6">UIViewController</p>
      </td>
    </tr>
    <tr>
      <td valign="top" class="td1">
        <p class="p6"><b>Declared in</b></p>
      </td>
      <td valign="top" class="td5">
        <p class="p6">MSTPMapStopMainViewController.h</p>
        <p class="p6">MSTPMapStopMainViewController.m</p>
      </td>
    </tr>
  </tbody>
</table>
<h3>Overview</h3>
<p class="p16">A view controller that facilitates the population of a map view with transit authority stop information. It creates the MKPointAnnotations by querying a StopsService object. This object gathers stop information and provides an API that facilitates access to the individual Stop model objects.</p>
</body>
</html>
